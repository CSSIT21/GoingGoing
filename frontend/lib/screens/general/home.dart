import 'dart:async';

import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/routes/routes.dart';
import 'package:going_going_frontend/models/car_info.dart';
import 'package:going_going_frontend/models/schedule.dart';
import 'package:provider/provider.dart';

import '../../config/themes/app_colors.dart';
import '../../models/home/card_info.dart';
import '../../services/provider/schedule_provider.dart';
import '../../services/provider/car_information_provider.dart';
import '../../services/rest/profile_api.dart';
import '../../services/rest/schedule_api.dart';
import '../../widgets/common/appointment_card.dart';
import '../../widgets/common/default_card.dart';
import '../../widgets/common/offer_card.dart';
import '../../widgets/home/search.dart';
import '../../widgets/home/title_box.dart';
import '../../widgets/home/type_chips.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Schedule> _appointments;
  late List<Schedule> _histories;
  late List<CarInfo> _appointmentCarInfoList;
  late List<CarInfo> _historyCarInfoList;

  String selectedChoice = "Schedule";
  bool _isLoading = true;

  Future<void> fetchAppointmentsSchedule() async {
    final data = await ScheduleApi.getAppointmentSchedules(context);
    if (data != null) {
      context.read<ScheduleProvider>().appointmentSchedules = data.schedules;
      context.read<CarInfoProvider>().appointmentCarInfos = data.carInfos;
      setState(() {
        _appointments = data.schedules;
        _appointmentCarInfoList = data.carInfos;
      });
    }
  }

  Future<void> fetchHistoriesSchedule() async {
    final data = await ScheduleApi.getHistorySchedules(context);
    if (data != null) {
      context.read<ScheduleProvider>().historySchedules = data.schedules;
      context.read<CarInfoProvider>().historyCarInfos = data.carInfos;
      setState(() {
        _histories = data.schedules;
        _historyCarInfoList = data.carInfos;
      });
    }
  }

  void fetchAll() async {
    await fetchAppointmentsSchedule();
    await fetchHistoriesSchedule();
    await ProfileApi.getUserProfile(context);
    setState(() {
      _isLoading = false;
    });
  }

  setSelectedChoice(String choice) {
    setState(() {
      selectedChoice = choice;
    });
    debugPrint(selectedChoice);
  }

  handleAppointmentBtn(int scheduleId) {
    // Set timer
    Timer(const Duration(seconds: 3), () async {
      debugPrint("Call API here!");
      context.read<ScheduleProvider>().selectedId = scheduleId;
      ScheduleApi.patchIsEnd(
          context.read<ScheduleProvider>().selectedId, context);
      await Navigator.pushNamed(context, Routes.endRide);
      setState(() {
        _isLoading = true;
      });
      fetchAll();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 92,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 69),
                          child: Search(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    const TitleBox(),
                    const SizedBox(
                      height: 28,
                    ),
                    TypeChips(
                        selectedChoice: selectedChoice,
                        setSelectedChoice: setSelectedChoice),
                    const SizedBox(
                      height: 12,
                    ),
                    selectedChoice == "Schedule"
                        ? Container(
                            margin: const EdgeInsets.only(
                                left: 32, top: 30, bottom: 8),
                            child: Text(
                              "Scheduled",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          )
                        : Container(),
                  ],
                ),
                selectedChoice == "History"
                    ? _histories.isEmpty || _historyCarInfoList.isEmpty
                        ? const DefaultCard(text: "You don't have any history")
                        : Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 20),
                              itemBuilder: (context, index) => OfferCard(
                                info: OfferCardInfo(
                                  _histories[index],
                                  _historyCarInfoList
                                      .firstWhere((el) =>
                                          el.ownerId ==
                                          _histories[index].party.driverId)
                                      .carRegis,
                                ),
                                pageName: 'history',
                              ),
                              itemCount: _histories.length,
                            ),
                          )
                    : _appointments.isEmpty || _appointmentCarInfoList.isEmpty
                        ? const DefaultCard(text: "You don't have any schedule")
                        : Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 20),
                              itemBuilder: (context, index) => AppointmentCard(
                                handleAppointmentBtn: handleAppointmentBtn,
                                info: AppointmentCardInfo(
                                  _appointments[index],
                                  _appointmentCarInfoList
                                      .firstWhere((el) =>
                                          el.ownerId ==
                                          _appointments[index].party.driverId)
                                      .carRegis,
                                ),
                                pageName: 'home',
                              ),
                              itemCount: _appointments.length,
                            ),
                          ),
              ],
            ),
    );
  }
}

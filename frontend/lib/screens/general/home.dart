import 'dart:async';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../config/routes/routes.dart';
import '../../config/themes/app_colors.dart';
import '../../models/car_info.dart';
import '../../models/schedule.dart';
import '../../models/home/card_info.dart';
import '../../models/response/common/info_response.dart';
import '../../services/provider/schedule_provider.dart';
import '../../services/provider/car_information_provider.dart';
import '../../services/provider/user_provider.dart';
import '../../services/rest/party_api.dart';
import '../../services/rest/profile_api.dart';
import '../../services/rest/schedule_api.dart';
import '../../widgets/common/alert_dialog.dart';
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

  String _selectedChoice = "Schedule";
  bool _isLoading = true;

  Future<void> _fetchAppointmentsSchedule() async {
    final data = await ScheduleApi.getAppointmentSchedules(context);
    if (data != null) {
      context.read<ScheduleProvider>().appointmentSchedules = data.schedules;
      context.read<CarInfoProvider>().appointmentCarInfoList = data.carInfoList;
      setState(() {
        _appointments = data.schedules;
        _appointmentCarInfoList = data.carInfoList;
      });
    }
  }

  Future<void> _fetchHistoriesSchedule() async {
    final data = await ScheduleApi.getHistorySchedules(context);
    if (data != null) {
      context.read<ScheduleProvider>().historySchedules = data.schedules;
      context.read<CarInfoProvider>().historyCarInfoList = data.carInfoList;
      setState(() {
        _histories = data.schedules;
        _historyCarInfoList = data.carInfoList;
      });
    }
  }

  Future<void> _fetchAll() async {
    await _fetchAppointmentsSchedule();
    await _fetchHistoriesSchedule();
    await ProfileApi.getUserProfile(context);
    setState(() {
      _isLoading = false;
    });
  }

  void _setSelectedChoice(String choice) {
    setState(() {
      _selectedChoice = choice;
    });
  }

  Future<void> _handleGetInCar(int scheduleId) async {
    await PartyApi.patchConfirm(_appointments.firstWhere((el) => el.id == scheduleId).partyId);
    await _fetchAppointmentsSchedule();

    // * Set timer
    Timer(const Duration(seconds: 3), () async {
      final result = await ScheduleApi.patchIsEnd(scheduleId, context);

      if (result is InfoResponse) {
        showAlertDialog(context, result.message!, title: "GOODBYE :)", onOk: () async {
          context.read<ScheduleProvider>().selectedId = scheduleId;
          await Navigator.pushNamed(context, Routes.endRide);

          setState(() {
            _isLoading = true;
          });
          _fetchAll();
        });
      } else {
        showAlertDialog(context, result.message!);
      }
    });
  }

  Future<void> _onSearchPressed() async {
    final partyId = await Navigator.pushNamed(context, Routes.search);

    if (partyId != null) {
      // * Set timer
      Timer(const Duration(seconds: 3), () async {
        final result = await PartyApi.patchAcceptRequest(
          partyId as int,
          context.read<UserProvider>().id,
        );
        if (result is InfoResponse) {
          showAlertDialog(
            context,
            "Your request has been accepted. Now you join the party!",
            title: "Hello!",
          );
        } else {
          showAlertDialog(context, result.message!);
        }

        setState(() {
          _isLoading = true;
        });
        _fetchAll();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAll();
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
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 69),
                          child: Search(_onSearchPressed),
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
                        selectedChoice: _selectedChoice, setSelectedChoice: _setSelectedChoice),
                    const SizedBox(
                      height: 12,
                    ),
                    _selectedChoice == "Schedule"
                        ? Container(
                            margin: const EdgeInsets.only(left: 32, top: 30, bottom: 8),
                            child: Text(
                              "Scheduled",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          )
                        : Container(),
                  ],
                ),
                _selectedChoice == "History"
                    ? _histories.isEmpty || _historyCarInfoList.isEmpty
                        ? const DefaultCard(text: "You don't have any history")
                        : Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                              itemBuilder: (context, index) => OfferCard(
                                info: OfferCardInfo(
                                  _histories[index],
                                  _historyCarInfoList
                                      .firstWhere(
                                          (el) => el.ownerId == _histories[index].party.driverId)
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
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                              itemBuilder: (context, index) => AppointmentCard(
                                handleAppointmentBtn: _handleGetInCar,
                                info: AppointmentCardInfo(
                                  _appointments[index],
                                  _appointmentCarInfoList
                                      .firstWhere(
                                          (el) => el.ownerId == _appointments[index].party.driverId)
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

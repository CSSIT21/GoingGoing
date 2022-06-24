import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/themes/app_colors.dart';
import '../../models/home/card_info.dart';
import '../../services/provider/schedule_provider.dart';
import '../../services/provider/car_informations_provider.dart';
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
  String selectedChoice = "Schedule";

  @override
  void initState() {
    super.initState();
    ScheduleApi.getAppointmentSchedules(context);
  }

  setSelectedChoice(String choice) {
    setState(() {
      selectedChoice = choice;
    });
    debugPrint(selectedChoice);
  }

  @override
  Widget build(BuildContext context) {
    final _appointments = context
        .select((ScheduleProvider schedule) => schedule.appointmentSchedules);
    final _appointmentCarInfos = context
        .select((CarInfoProvider carInfo) => carInfo.appointmentCarInfos);

    final _histories = context
        .select((ScheduleProvider schedule) => schedule.historySchedules);
    final _historyCarInfos =
        context.select((CarInfoProvider carInfo) => carInfo.historyCarInfos);

    return Scaffold(
      body: Column(
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
                    padding: EdgeInsets.only(left: 20, right: 20, top: 69),
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
                      margin: const EdgeInsets.only(left: 32, top: 30),
                      child: Text(
                        "Scheduled",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    )
                  : Container(),
            ],
          ),
          selectedChoice == "History"
              ? _histories.isEmpty || _historyCarInfos.isEmpty
                  ? const DefaultCard(text: "history")
                  : Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 20),
                        itemBuilder: (context, index) => OfferCard(
                          info: OfferCardInfo(
                            _histories[index],
                            _historyCarInfos
                                .firstWhere((el) =>
                                    el.ownerId ==
                                    _histories[index].party.driverId)
                                .carRegis,
                          ),
                        ),
                        itemCount: _histories.length,
                      ),
                    )
              : _appointments.isEmpty || _appointmentCarInfos.isEmpty
                  ? const DefaultCard(text: "schedule")
                  : Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 20),
                        itemBuilder: (context, index) => AppointmentCard(
                          info: AppointmentCardInfo(
                            _appointments[index],
                            _appointmentCarInfos
                                .firstWhere((el) =>
                                    el.ownerId ==
                                    _appointments[index].party.driverId)
                                .carRegis,
                          ),
                        ),
                        itemCount: _appointments.length,
                      ),
                    ),
        ],
      ),
    );
  }
}

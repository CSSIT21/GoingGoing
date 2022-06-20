import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/config/themes/app_colors.dart';
import '/models/schedule.dart';
import '/models/home/card_info.dart';
import '/services/provider/schedule_provider.dart';
import '/widgets/common/appointment_card.dart';
import '/widgets/common/default_card.dart';
import '/widgets/common/offer_card.dart';
import '/widgets/home/search.dart';
import '/widgets/home/title_box.dart';
import '/widgets/home/type_chips.dart';

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

    if (mounted) {
      // ScheduleApi.getSchedules();
    }
  }

  setSelectedChoice(String choice) {
    setState(() {
      selectedChoice = choice;
    });
    debugPrint(selectedChoice);
  }

  @override
  Widget build(BuildContext context) {
    var appointments = context.watch<ScheduleProvider>().homeSchedules;
    var histories = context.watch<ScheduleProvider>().historySchedules;

    return Scaffold(
        backgroundColor: Colors.white,
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
                TypeChips(selectedChoice: selectedChoice, setSelectedChoice: setSelectedChoice),
                const SizedBox(
                  height: 45,
                ),
              ],
            ),
            selectedChoice == "History"
                ? histories.isEmpty
                    ? const DefaultCard(text: "history")
                    : Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) =>
                              OfferCard(info: OfferCardInfo(histories[index])),
                          itemCount: histories.length,
                        ),
                      )
                : appointments.isEmpty
                    ? const DefaultCard(text: "schedule")
                    : Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) =>
                              AppointmentCard(info: AppointmentCardInfo(appointments[index])),
                          itemCount: appointments.length,
                        ),
                      ),
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/themes/app_colors.dart';
import 'package:going_going_frontend/models/home/information.dart';
import 'package:going_going_frontend/services/provider/schedule_provider.dart';
import 'package:going_going_frontend/widgets/common/appointment_card.dart';
import 'package:going_going_frontend/widgets/common/default_card.dart';
import 'package:going_going_frontend/widgets/common/offer_card.dart';
import 'package:going_going_frontend/widgets/home/search.dart';
import 'package:going_going_frontend/widgets/home/title_box.dart';
import 'package:going_going_frontend/widgets/home/type_chips.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AppointmentCardInfo> appointments = List.empty();
  List<OfferCardInfo> histories = List.empty();
  String selectedChoice = "Schedule";

  @override
  void initState() {
    super.initState();
    setState(() {
      appointments = context.read<ScheduleProvider>().appointments;
      histories = context.read<ScheduleProvider>().histories;
    });
  }

  setSelectedChoice(String choice) {
    setState(() {
      selectedChoice = choice;
    });
    debugPrint(selectedChoice);
  }

  @override
  Widget build(BuildContext context) {
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
                TypeChips(
                    selectedChoice: selectedChoice,
                    setSelectedChoice: setSelectedChoice),
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
                              OfferCard(info: histories[index]),
                          itemCount: histories.length,
                        ),
                      )
                : appointments.isEmpty
                    ? const DefaultCard(text: "schedule")
                    : Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) =>
                              AppointmentCard(info: appointments[index]),
                          itemCount: appointments.length,
                        ),
                      ),
          ],
        ));
  }
}

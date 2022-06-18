import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/themes/app_colors.dart';
import 'package:going_going_frontend/models/home/information.dart';
import 'package:going_going_frontend/widgets/common/appointment_card.dart';
import 'package:going_going_frontend/widgets/common/default_card.dart';
import 'package:going_going_frontend/widgets/common/offer_card.dart';
import 'package:going_going_frontend/widgets/home/search.dart';
import 'package:going_going_frontend/widgets/home/title_box.dart';
import 'package:going_going_frontend/widgets/home/type_chips.dart';
import 'package:going_going_frontend/widgets/search/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<OfferCardInfo> histories = List.empty();
  List<OfferCardInfo> histories = [
    OfferCardInfo(
        id: 0,
        name: "KMUTT, Bangmod",
        date: "23-03-2022",
        time: "6.00 PM",
        carRegistration: "AB-9316",
        partySize: 4,
        address: "KMUTT,  Pracha Uthit Rd.",
        distance: 100),
    OfferCardInfo(
        id: 1,
        name: "Seacon Bangkae",
        date: "23-03-2022",
        time: "6.00 PM",
        carRegistration: "AB-9316",
        partySize: 4,
        address: "Bangkae",
        distance: 100),
    OfferCardInfo(
        id: 2,
        name: "KMUTT, CS@SIT",
        date: "23-03-2022",
        time: "6.00 PM",
        carRegistration: "AB-9316",
        partySize: 4,
        address: "KMUTT,  Pracha Uthit Rd.",
        distance: 100)
  ];

  // List<AppointmentCardInfo> schedules = List.empty();
  List<AppointmentCardInfo> schedules = [
    AppointmentCardInfo(
        id: 0,
        type: "confirmed",
        date: "2022-05-30",
        time: "01:00 PM",
        carRegistration: "AB-9316",
        partySize: 5,
        address: "address1",
        startTripDateTime: DateTime.parse("2022-05-30 13:00:00.000"),
        distance: 100),
    AppointmentCardInfo(
        id: 0,
        type: "pending",
        date: DateTime.now().add(const Duration(hours: 2)).toString().substring(0,10),
        time: "${
          DateTime.now()
              .add(const Duration(hours: 2))
              .toString()
              .substring(11, 16)
        } PM",
        carRegistration: "CD-2290",
        partySize: 4,
        address: "address2",
        startTripDateTime: DateTime.now().add(const Duration(hours: 2)),
        distance: 100.00)
  ];
  String selectedChoice = "Schedule";

  @override
  void initState() {
    super.initState();
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
                : schedules.isEmpty
                    ? const DefaultCard(text: "schedule")
                    : Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) =>
                              AppointmentCard(info: schedules[index]),
                          itemCount: schedules.length,
                        ),
                      ),
          ],
        ));
  }
}

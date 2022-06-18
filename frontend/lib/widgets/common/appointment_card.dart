import 'dart:async';

import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/routes/routes.dart';
import 'package:going_going_frontend/config/themes/app_colors.dart';
import 'package:going_going_frontend/models/home/information.dart';
import 'package:going_going_frontend/services/provider/end_ride_provider.dart';
import 'package:going_going_frontend/widgets/common/button.dart';
import 'package:going_going_frontend/widgets/home/info_box.dart';
import 'package:provider/provider.dart';

class AppointmentCard extends StatefulWidget {
  final AppointmentCardInfo info;

  const AppointmentCard({Key? key, required this.info}) : super(key: key);

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  bool isDisbled = false;
  String type = "Pending";

  @override
  void initState() {
    super.initState();
    setState(() {
      isDisbled = widget.info.startTripDateTime.isBefore(DateTime.now());
      type = widget.info.type;
    });
  }


  calculatePrice() {
    context.read<EndRideProvider>().partySize = widget.info.partySize;
    context.read<EndRideProvider>().totalAndPrice = widget.info.distance;
    print(context.watch<EndRideProvider>().total);
    print(context.watch<EndRideProvider>().price);
  }

  void handleGetInCarBtn()  {
    setState(() {
      isDisbled = true;
      type = "confirmed";
    });
    // Set timer
    Timer(const Duration(seconds: 3), () async {
      // await Call api --> change status and type(confirmed)
      debugPrint("Call API here!");
      // Calculate totalPrice from distance*35.0 in Provider
      await calculatePrice();
      // Push route EndRideScreen
      Navigator.pushNamed(context, Routes.endRide);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          margin: const EdgeInsets.only(left: 35, right: 35, bottom: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            height: 196,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey.withOpacity(0.2),
                  blurRadius: 10.0,
                  spreadRadius: 6,
                  offset: const Offset(
                    3, // Move to right 10  horizontally
                    6.0, // Move to bottom 10 Vertically
                  ),
                ),
              ],
              borderRadius: BorderRadius.circular(16.0),
              gradient: const LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  Color.fromRGBO(255, 243, 160, 100),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 28, right: 48, top: 18, bottom: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your appointment",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 4,
                            height: 4,
                            margin: const EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: type == "pending"
                                  ? AppColors.blackGrey
                                  : Colors.green,
                            ),
                          ),
                          Text(
                            type == "pending" ? "Pending" : "Confirmed",
                            style:
                                Theme.of(context).textTheme.subtitle2?.copyWith(
                                      fontSize: 10.0,
                                    ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      InfoBox(
                        date: widget.info.date,
                        time: widget.info.time,
                        partySize: widget.info.partySize,
                        carRegistration: widget.info.carRegistration,
                        address: widget.info.address,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 0),
                  child: Button(
                    text: "Get In the Car",
                    onPressed: handleGetInCarBtn,
                    disabled: isDisbled,
                    color: AppColors.secondaryColor,
                    textColor: AppColors.white,
                    fontSize: 11,
                  ),
                ),
              ],
            ), //declare your widget here
          ),
        )
      ],
    );
  }
}

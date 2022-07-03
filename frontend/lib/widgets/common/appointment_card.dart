import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/routes/routes.dart';
import '../../config/themes/app_colors.dart';
import '../../models/home/card_info.dart';
import '../../services/provider/schedule_provider.dart';
import '../../services/rest/schedule_api.dart';
import '../home/info_box.dart';
import 'button.dart';

class AppointmentCard extends StatefulWidget {
  final AppointmentCardInfo info;
  final String pageName;

  const AppointmentCard({Key? key, required this.info, required this.pageName}) : super(key: key);

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  bool isDisbled = false;
  bool isGetIn = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isDisbled = widget.info.startTripDateTime.isBefore(DateTime.now());
    });
  }

  void handleGetInCarBtn() {
    setState(() {
      isDisbled = true;
      isGetIn = true;
    });
    // Set timer
    Timer(const Duration(seconds: 3), () async {
      // await Call api --> change status and partyType
      debugPrint("Call API here!");
      ScheduleApi.patchIsEnd(widget.info.scheduleId, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: () {
          context.read<ScheduleProvider>().selectedId = widget.info.scheduleId;
          context.read<ScheduleProvider>().selectedRoute = widget.pageName;
          Navigator.pushNamed(context, Routes.offerDetail);
        },
        borderRadius: BorderRadius.circular(16.0),
        splashColor: AppColors.primaryColor,
        child: Container(
          padding: const EdgeInsets.only(left: 28, right: 28, top: 16, bottom: 12),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your appointment",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        margin: const EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.info.startTripDateTime.isBefore(DateTime.now())
                              ? AppColors.secondaryColor
                              : Colors.green,
                        ),
                      ),
                      Text(
                        widget.info.startTripDateTime.isBefore(DateTime.now())
                            ? "Pending"
                            : "Confirmed",
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              fontSize: 10.0,
                            ),
                      )
                    ],
                  ),
                  const SizedBox(height: 14),
                  InfoBox(
                    date: widget.info.date,
                    time: widget.info.time,
                    partySize: widget.info.partySize,
                    carRegistration: widget.info.carRegistration,
                    address: widget.info.address,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Button(
                  text: isGetIn ? "Start the trip" : "Get In the Car",
                  onPressed: handleGetInCarBtn,
                  disabled: isDisbled,
                  color: AppColors.secondaryColor,
                  textColor: AppColors.white,
                  fontSize: 11,
                  verticalPadding: 14,
                ),
              ),
            ],
          ), //declare your widget here
        ),
      ),
    );
  }
}

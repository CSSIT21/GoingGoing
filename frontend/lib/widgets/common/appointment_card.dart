import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/themes/app_colors.dart';
import 'package:going_going_frontend/models/home/information.dart';
import 'package:going_going_frontend/widgets/common/button.dart';
import 'package:going_going_frontend/widgets/home/info_box.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentCardInfo info;

  const AppointmentCard({Key? key, required this.info}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          // elevation: 2,
          margin: const EdgeInsets.only(left: 35, right: 35, bottom: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            height: 196,
            decoration: BoxDecoration(
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
                              color: info.type == "pending"
                                  ? AppColors.blackGrey
                                  : Colors.green,
                            ),
                          ),
                          Text(
                            info.type == "pending" ? "Pending" : "Confirmed",
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
                        date: info.date,
                        time: info.time,
                        partySize: info.partySize,
                        carRegistration: info.carRegistration,
                        address: info.address,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 0),
                  child: Button(
                    text: "Get In the Car",
                    onPressed: () {
                      print("Now");
                      print(info.startTripDateTime);
                      print(DateTime.now());
                    },
                    disabled: info.startTripDateTime.isBefore(DateTime.now()),
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

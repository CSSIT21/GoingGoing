import 'package:flutter/material.dart';
import '../../config/themes/app_colors.dart';
import '../../models/home/card_info.dart';
import '../home/info_box.dart';

class OfferCard extends StatelessWidget {
  final OfferCardInfo info;
  const OfferCard({Key? key, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          margin: const EdgeInsets.only(left: 35, right: 35, bottom: 32),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0), side: BorderSide.none),
          child: Container(
            height: 135,
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
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.primaryColor.withOpacity(0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.only(left: 28, right: 40, top: 18, bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      info.name,
                      style: Theme.of(context).textTheme.subtitle1,
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
                    )
                  ],
                )),
          ),
        )
      ],
    );
  }
}

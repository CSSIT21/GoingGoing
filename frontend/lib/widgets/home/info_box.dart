import 'package:flutter/material.dart';
import 'info_text_format.dart';

class InfoBox extends StatelessWidget {
  final String date;
  final String time;
  final int partySize;
  final String carRegistration;
  final String address;

  const InfoBox({
    Key? key,
    required this.date,
    required this.time,
    required this.partySize,
    required this.carRegistration,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InFoTextFormat(
                text: date,
                icon: Icons.date_range,
              ),
              InFoTextFormat(
                text: "${(partySize+1).toString()} Person",
                icon: Icons.person,
              ),
              InFoTextFormat(
                text: address,
                icon: Icons.place,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InFoTextFormat(
                text: time,
                icon: Icons.access_time,
              ),
              InFoTextFormat(
                text: carRegistration,
                icon: Icons.directions_car,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

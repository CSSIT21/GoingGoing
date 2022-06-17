import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/themes/app_colors.dart';
import 'package:going_going_frontend/widgets/home/info_box.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({Key? key}) : super(key: key);

  final String name = "KMUTT, Bangmod";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            height: 130,
            width: 320,
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
            child: Padding(
                padding:
                    const EdgeInsets.only(left: 24, right: 42,top: 18,bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(name),SizedBox(height: 16,), InfoBox()],
                )), //declare your widget here
          ),
        )
      ],
    );
  }
}

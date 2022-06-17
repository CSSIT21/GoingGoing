import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/themes/app_colors.dart';

class InFoTextFormat extends StatelessWidget {
  final String text;
  final IconData icon;
  const InFoTextFormat({Key? key, required this.text, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
         Icon(icon, color: AppColors.secondaryColor,size: 16,),
        const SizedBox(width: 2,),
        Text(
          text,
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }
}

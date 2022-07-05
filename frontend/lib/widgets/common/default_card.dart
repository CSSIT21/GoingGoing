import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class DefaultCard extends StatelessWidget {
  final String text;

  const DefaultCard({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(16.0),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(color: AppColors.blackGrey),
      ),
    );
  }
}

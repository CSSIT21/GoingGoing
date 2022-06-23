import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/themes/app_colors.dart';

class InFoTextFormat extends StatelessWidget {
  final String text;
  final IconData icon;
  const InFoTextFormat({Key? key, required this.text, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.secondaryColor,
            size: 16,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.headline4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

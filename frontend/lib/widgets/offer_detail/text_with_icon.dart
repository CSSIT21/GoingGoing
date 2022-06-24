import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class TextWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;

  const TextWithIcon({required this.text, required this.icon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
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
          Flexible(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText2,
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }
}

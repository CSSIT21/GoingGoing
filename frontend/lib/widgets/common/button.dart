import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final bool disabled;
  final double fontSize;
  final double verticalPadding;

  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    this.fontSize = 16.0,
    this.color = AppColors.primaryColor,
    this.textColor = AppColors.black,
    this.disabled = false,
    this.verticalPadding = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: disabled ? AppColors.white : textColor,
              fontSize: fontSize),
          textAlign: TextAlign.center,
        ),
      ),
      onPressed: disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        primary: disabled ? AppColors.grey : color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        shadowColor: Colors.transparent,
      ),
    );
  }
}

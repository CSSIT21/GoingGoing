import 'package:flutter/material.dart';
import '../../config/themes/app_colors.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final bool disabled;
  final double fontSize;

  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    this.fontSize = 16.0,
    this.color = AppColors.primaryColor,
    this.textColor = AppColors.black,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: disabled ? AppColors.blackGrey : textColor, fontSize: fontSize),
          textAlign: TextAlign.center,
        ),
      ),
      onPressed: disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        primary: disabled ? AppColors.grey : color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../config/themes/app_colors.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final bool disabled;

  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.primaryColor,
    this.textColor = AppColors.black,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: disabled ? AppColors.grey : textColor),
          textAlign: TextAlign.center,
        ),
      ),
      onPressed: disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

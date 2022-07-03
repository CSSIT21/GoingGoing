import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

showAlertDialog(BuildContext context, String message, [String title = "SOMETHING WRONG!"]) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.of(context, rootNavigator: true).pop();
        });
        return AlertDialog(
          title: Text(title, style: const TextStyle(color: AppColors.white)),
          backgroundColor: AppColors.grey3,
          content: Text(message, style: const TextStyle(color: AppColors.white)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
              child: const Text(
                'OK',
                style: TextStyle(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      });
}

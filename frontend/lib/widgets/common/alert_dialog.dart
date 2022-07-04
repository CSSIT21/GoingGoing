import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

showAlertDialog(
  BuildContext context,
  String message, {
  bool success = false,
  String title = "",
  Function? onOk,
}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title.isEmpty
                ? success
                    ? "SUCCESS"
                    : "SOMETHING WRONG!"
                : title,
            style: const TextStyle(color: AppColors.black),
          ),
          backgroundColor: AppColors.white.withOpacity(0.8),
          content:
              Text(message, style: const TextStyle(color: AppColors.black)),
          contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 2.0),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
              child: const Text(
                'OK',
                style: TextStyle(color: AppColors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      }).then((_) => onOk?.call());
}

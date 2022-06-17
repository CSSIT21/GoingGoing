import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class NoResultText extends StatelessWidget {
  const NoResultText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'No suggest location found',
      style: Theme.of(context)
          .textTheme
          .subtitle1
          ?.copyWith(color: AppColors.blackGrey.withOpacity(0.5)),
      textAlign: TextAlign.left,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/themes/app_colors.dart';

class FilterHeader extends StatelessWidget {
  final VoidCallback onClear;

  const FilterHeader({required this.onClear, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Offer Details',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          TextButton(
            onPressed: onClear,
            child: Text(
              'Clear All',
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: AppColors.blackGrey.withOpacity(0.6),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

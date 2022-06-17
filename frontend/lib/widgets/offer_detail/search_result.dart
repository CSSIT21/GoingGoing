import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 19),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: AppColors.blackGrey,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'Search by location',
            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: AppColors.blackGrey),
          ),
        ],
      ),
    );
  }
}

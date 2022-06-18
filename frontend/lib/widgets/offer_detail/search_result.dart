import 'package:flutter/material.dart';
import 'package:going_going_frontend/services/provider/search_provider.dart';
import 'package:provider/provider.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.search,
                color: AppColors.blackGrey,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                context.read<SearchProvider>().name,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.filter_list,
              color: AppColors.blackGrey,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/themes/app_colors.dart';
import '../../services/provider/search_provider.dart';

class SearchResultBar extends StatelessWidget {
  final VoidCallback onFilterTap;

  const SearchResultBar(this.onFilterTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.search,
                  color: AppColors.blackGrey,
                  size: 20,
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    context.read<SearchProvider>().place.name,
                    style: Theme.of(context).textTheme.bodyText2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: onFilterTap,
              child: const SizedBox(
                width: 34,
                height: 34,
                child: Icon(
                  Icons.filter_list,
                  color: AppColors.blackGrey,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

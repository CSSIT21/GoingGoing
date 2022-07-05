import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../../models/filter.dart';

class FilterSection extends StatelessWidget {
  final List<Filter> filters;
  final Function(String key, bool value) onTap;

  const FilterSection(this.filters, {required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Filter',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: filters.map((filter) {
              return InkWell(
                highlightColor: Colors.transparent,
                splashColor: AppColors.primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primaryColor),
                    color: filter.value
                        ? AppColors.primaryColor
                        : Colors.transparent,
                  ),
                  child: Text(
                    filter.name,
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                onTap: () => onTap(filter.name, !filter.value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

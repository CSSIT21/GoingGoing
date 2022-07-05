import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value) onChanged;

  const SearchBar(this.controller, this.onChanged, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: controller,
      onChanged: (value) => onChanged(value),
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        filled: true,
        fillColor: AppColors.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.blackGrey,
          size: 20,
        ),
        hintText: 'Search by location',
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText2
            ?.copyWith(color: AppColors.blackGrey),
      ),
    );
  }
}

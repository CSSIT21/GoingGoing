import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/provider/search_provider.dart';
import '../../config/themes/app_colors.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 19),
      decoration: BoxDecoration(
        color: AppColors.grey,
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
            Icons.location_on,
            color: AppColors.blackGrey,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            context.read<SearchProvider>().address,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(color: AppColors.blackGrey),
          ),
        ],
      ),
    );
  }
}

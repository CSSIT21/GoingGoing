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
      margin: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 19),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.location_on,
            color: AppColors.blackGrey,
            size: 20,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              // context.read<SearchProvider>().address,
              'KMUTT,  Pracha Uthit Rd., Klongtoey, Bangkok, Thailand',
              style: Theme.of(context).textTheme.bodyText2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

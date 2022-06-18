import 'package:flutter/material.dart';

import '../../widgets/common/back_appbar.dart';
import '../../widgets/offer_detail/address_bar.dart';
import '../../widgets/offer_detail/map.dart';

class OfferDetailScreen extends StatelessWidget {
  const OfferDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(),
      body: Column(
        children: [
          const AddressBar(),
          const Map(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Driver\'s Information',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

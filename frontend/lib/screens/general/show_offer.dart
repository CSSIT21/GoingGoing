import 'package:flutter/material.dart';

import '../../widgets/common/back_appbar.dart';
import '../../widgets/offer_detail/search_result.dart';

class ShowOfferScreen extends StatelessWidget {
  const ShowOfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: SearchResult(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Column(
              children: [
                Text(
                  'Offer',
                  style: Theme.of(context).textTheme.headline1,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

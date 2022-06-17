import 'package:flutter/material.dart';
import 'package:going_going_frontend/services/provider/search_provider.dart';
import 'package:going_going_frontend/widgets/common/offer_card.dart';
import 'package:provider/provider.dart';

import '../../widgets/common/back_appbar.dart';
import '../../widgets/offer_detail/search_result.dart';

class ShowOfferScreen extends StatefulWidget {
  const ShowOfferScreen({Key? key}) : super(key: key);

  @override
  State<ShowOfferScreen> createState() => _ShowOfferScreenState();
}

class _ShowOfferScreenState extends State<ShowOfferScreen> {
  final _offers = [];

  @override
  void initState() {
    final address = context.read<SearchProvider>().address;
    // do api call to get offers
    super.initState();
  }

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
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => const OfferCard(),
                    itemCount: _offers.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

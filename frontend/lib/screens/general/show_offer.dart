import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/widgets/show_offer/search_result_bar.dart';
import '/widgets/show_offer/offer_title.dart';
import '/models/home/card_info.dart';
import '/services/provider/search_provider.dart';
import '/widgets/common/default_card.dart';
import '/widgets/common/offer_card.dart';
import '/widgets/common/back_appbar.dart';

class ShowOfferScreen extends StatefulWidget {
  const ShowOfferScreen({Key? key}) : super(key: key);

  @override
  State<ShowOfferScreen> createState() => _ShowOfferScreenState();
}

class _ShowOfferScreenState extends State<ShowOfferScreen> {
  final _offers = <OfferCardInfo>[];

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
            child: SearchResultBar(),
          ),
          const SizedBox(height: 16),
          const OfferTitle(),
          const SizedBox(height: 36),
          _offers.isEmpty
              ? const DefaultCard(text: "offer")
              : Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => OfferCard(info: _offers[index]),
                    itemCount: _offers.length,
                  ),
                ),
        ],
      ),
    );
  }
}

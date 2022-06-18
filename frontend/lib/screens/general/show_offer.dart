import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/home/information.dart';
import '../../services/provider/search_provider.dart';
import '../../widgets/common/offer_card.dart';
import '../../widgets/common/back_appbar.dart';
import '../../widgets/offer_detail/search_result.dart';

class ShowOfferScreen extends StatefulWidget {
  const ShowOfferScreen({Key? key}) : super(key: key);

  @override
  State<ShowOfferScreen> createState() => _ShowOfferScreenState();
}

class _ShowOfferScreenState extends State<ShowOfferScreen> {
  final _offers = <OfferCardInfo>[
    OfferCardInfo(
        id: 0,
        name: "KMUTT, Bangmod",
        date: "23-03-2022",
        time: "6.00 PM",
        carRegistration: "AB-9316",
        partySize: 4,
        address: "KMUTT,  Pracha Uthit Rd."),
    OfferCardInfo(
        id: 1,
        name: "Seacon Bangkae",
        date: "23-03-2022",
        time: "6.00 PM",
        carRegistration: "AB-9316",
        partySize: 4,
        address: "Bangkae"),
    OfferCardInfo(
        id: 2,
        name: "KMUTT, CS@SIT",
        date: "23-03-2022",
        time: "6.00 PM",
        carRegistration: "AB-9316",
        partySize: 4,
        address: "KMUTT,  Pracha Uthit Rd.")
  ];

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
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          //   child: Column(
          //     children: [
          //       Text(
          //         'Offer',
          //         style: Theme.of(context).textTheme.headline1,
          //         textAlign: TextAlign.left,
          //       ),
          //       const SizedBox(height: 16),
          //       Expanded(
          //         child: ListView.builder(
          //           itemBuilder: (context, index) => OfferCard(info: _offers[index]),
          //           itemCount: _offers.length,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

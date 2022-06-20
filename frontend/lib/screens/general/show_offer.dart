import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/services/provider/schedule_provider.dart';
import '/models/home/card_info.dart';
import '/widgets/offer_detail/offer_title.dart';
import '/widgets/common/default_card.dart';
import '/widgets/common/offer_card.dart';
import '/widgets/common/back_appbar.dart';
import '/widgets/offer_detail/search_result.dart';

class ShowOfferScreen extends StatelessWidget {
  const ShowOfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _schedules = context.select((ScheduleProvider provider) => provider.searchSchedules);

    return Scaffold(
      appBar: const BackAppBar(),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: SearchResult(),
          ),
          const SizedBox(height: 16),
          const OfferTitle(),
          const SizedBox(height: 36),
          _schedules.isEmpty
              ? const DefaultCard(text: "offer")
              : Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) =>
                        OfferCard(info: OfferCardInfo(_schedules[index])),
                    itemCount: _schedules.length,
                  ),
                ),
        ],
      ),
    );
  }
}

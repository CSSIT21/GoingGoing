import 'package:flutter/material.dart';
import 'package:going_going_frontend/services/provider/car_informations_provider.dart';
import 'package:provider/provider.dart';

import '/services/provider/schedule_provider.dart';
import '/models/home/card_info.dart';
import '/widgets/show_offer/offer_title.dart';
import '/widgets/common/default_card.dart';
import '/widgets/common/offer_card.dart';
import '/widgets/common/back_appbar.dart';
import '/widgets/show_offer/search_result_bar.dart';

class ShowOfferScreen extends StatelessWidget {
  const ShowOfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _schedules = context.select((ScheduleProvider schedule) => schedule.searchSchedules);
    final _carInfos = context.select((CarInfoProvider carInfo) => carInfo.searchCarInfos);

    return Scaffold(
      appBar: const BackAppBar(),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: SearchResultBar(),
          ),
          const OfferTitle(),
          _schedules.isEmpty
              ? const DefaultCard(text: "offer")
              : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                    itemBuilder: (context, index) => OfferCard(
                      info: OfferCardInfo(
                        _schedules[index],
                        _carInfos
                            .firstWhere((el) => el.ownerId == _schedules[index].party.driverId)
                            .carRegis,
                        maxSize: true,
                      ),
                      pageName: 'search',
                    ),
                    itemCount: _schedules.length,
                  ),
                ),
        ],
      ),
    );
  }
}

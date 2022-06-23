import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/schedule.dart';
import '../../services/provider/schedule_provider.dart';
import '../../widgets/offer_detail/detail_section.dart';
import '../../widgets/common/back_appbar.dart';
import '../../widgets/common/button.dart';
import '../../widgets/common/profile_section.dart';
import '../../widgets/offer_detail/address_bar.dart';
import '../../widgets/offer_detail/map.dart';

class OfferDetailScreen extends StatelessWidget {
  const OfferDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _args = ModalRoute.of(context)!.settings.arguments as OfferDetailArguments;

    final _schedule = context.select((ScheduleProvider provider) {
      switch (_args.previousRoute) {
        case 'search':
          return provider.getSearchScheduleById(provider.selectedId);
        case 'home':
          return provider.getHomeScheduleById(provider.selectedId);
        case 'history':
          return provider.getHistoryScheduleById(provider.selectedId);
      }
    }) as Schedule;

    return Scaffold(
      appBar: const BackAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressBar(_schedule.destinationLocation.address),
            Map(_schedule.startLocation, _schedule.destinationLocation),
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
                  const SizedBox(height: 16),
                  const ProfileSection(
                    firstname: 'Barbie',
                    lastname: 'Roberts',
                    gender: 'Female',
                    age: '35',
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: DetailSection(),
                  ),
                  Button(
                    text: 'Request Offer',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OfferDetailArguments {
  final String previousRoute;

  OfferDetailArguments(this.previousRoute);
}

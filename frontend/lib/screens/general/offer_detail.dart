import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: const BackAppBar(),
      body: SingleChildScrollView(
        child: Column(
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

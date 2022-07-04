import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/themes/app_colors.dart';
import '../../config/routes/routes.dart';
import '../../models/car_info.dart';
import '../../models/schedule.dart';
import '../../services/provider/schedule_provider.dart';
import '../../services/provider/car_information_provider.dart';
import '../../widgets/offer_detail/detail_section.dart';
import '../../widgets/common/back_appbar.dart';
import '../../widgets/common/button.dart';
import '../../widgets/common/profile_section.dart';
import '../../widgets/offer_detail/address_bar.dart';
import '../../widgets/offer_detail/map.dart';

class OfferDetailScreen extends StatefulWidget {
  const OfferDetailScreen({Key? key}) : super(key: key);

  @override
  State<OfferDetailScreen> createState() => _OfferDetailScreenState();
}

class _OfferDetailScreenState extends State<OfferDetailScreen> {
  late bool _isRequested;

  void _onCliked() async {
    if (_isRequested) {
      // TODO: call api to cancel request
    } else {
      // TODO: call api to request offer
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.of(context).pushNamed(Routes.waiting);
      });
    }

    setState(() {
      _isRequested = !_isRequested;
    });
  }

  @override
  void initState() {
    super.initState();
    // _isRequested = ScheduleApi.getIsRequested(context.read<ScheduleProvider>.selectedId);
    _isRequested = true;
  }

  @override
  Widget build(BuildContext context) {
    final _args = ModalRoute.of(context)!.settings.arguments as OfferDetailArguments;

    final _schedule = context.select((ScheduleProvider provider) {
      switch (_args.previousRoute) {
        case 'search':
          return provider.getSearchScheduleById(provider.selectedId);
        case 'home':
          return provider.getAppointmentScheduleById(provider.selectedId);
        case 'history':
          return provider.getHistoryScheduleById(provider.selectedId);
      }
    }) as Schedule;

    final _carInfo = context.select((CarInfoProvider provider) {
      switch (_args.previousRoute) {
        case 'search':
          return provider.getSearchCarInfoById(_schedule.party.driverId);
        case 'home':
          return provider.getAppointmentCarInfoById(_schedule.party.driverId);
        case 'history':
          return provider.getHistoryCarInfoById(_schedule.party.driverId);
      }
    }) as CarInfo;

    return Scaffold(
      appBar: const BackAppBar(),
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressBar(_schedule.destinationLocation.address),
            Map(_schedule.startLocation, _schedule.destinationLocation),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Driver\'s Information',
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const ProfileSection(
                    firstname: 'Barbie',
                    lastname: 'Roberts',
                    gender: 'Female',
                    age: '35',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: DetailSection(_schedule, _carInfo),
                  ),
                  _args.previousRoute == 'history'
                      ? Container()
                      : Button(
                          text: _isRequested ? 'Cancel Request' : 'Request Offer',
                          color: _isRequested ? AppColors.grey : AppColors.primaryColor,
                          onPressed: _onCliked,
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

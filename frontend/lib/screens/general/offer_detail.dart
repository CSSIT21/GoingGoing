import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/themes/app_colors.dart';
import '../../config/routes/routes.dart';
import '../../models/car_info.dart';
import '../../models/schedule.dart';
import '../../models/response/check_request_response.dart';
import '../../services/rest/party_api.dart';
import '../../services/provider/schedule_provider.dart';
import '../../services/provider/car_informations_provider.dart';
import '../../widgets/common/alert_dialog.dart';
import '../../widgets/common/back_appbar.dart';
import '../../widgets/common/button.dart';
import '../../widgets/common/profile_section.dart';
import '../../widgets/offer_detail/detail_section.dart';
import '../../widgets/offer_detail/address_bar.dart';
import '../../widgets/offer_detail/map.dart';

class OfferDetailScreen extends StatefulWidget {
  const OfferDetailScreen({Key? key}) : super(key: key);

  @override
  State<OfferDetailScreen> createState() => _OfferDetailScreenState();
}

class _OfferDetailScreenState extends State<OfferDetailScreen> {
  bool _isLoading = true;

  late CheckRequestResponse _checkRequest;
  late Schedule _schedule;
  late CarInfo _carInfo;

  void _onRequest() async {
    setState(() {
      _isLoading = true;
    });

    if (_checkRequest.isRequested) {
      // TODO: call api to cancel request
    } else {
      // TODO: call api to request offer
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.of(context).pushNamed(Routes.waiting);
      });
    }

    setState(() {
      _checkRequest.isRequested = !_checkRequest.isRequested;
      _isLoading = false;
    });
  }

  void _onLoadPage(String route, int scheduleId) async {
    switch (route) {
      case 'search':
        _schedule = context.read<ScheduleProvider>().getSearchScheduleById(scheduleId);
        _carInfo = context.read<CarInfoProvider>().getSearchCarInfoById(_schedule.party.driverId);
        break;
      case 'home':
        _schedule = context.read<ScheduleProvider>().getAppointmentScheduleById(scheduleId);
        _carInfo =
            context.read<CarInfoProvider>().getAppointmentCarInfoById(_schedule.party.driverId);
        break;
      case 'history':
        _schedule = context.read<ScheduleProvider>().getHistoryScheduleById(scheduleId);
        _carInfo = context.read<CarInfoProvider>().getHistoryCarInfoById(_schedule.party.driverId);
        break;
    }

    if (context.read<ScheduleProvider>().selectedRoute == 'search') {
      final data = await PartyApi.getIsRequested(_schedule.partyId);
      if (data is CheckRequestResponse) {
        setState(() {
          _checkRequest = data;
          _isLoading = false;
        });
      } else {
        showAlertDialog(context, data.message);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _onLoadPage(
      context.read<ScheduleProvider>().selectedRoute,
      context.read<ScheduleProvider>().selectedId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                        context.read<ScheduleProvider>().selectedRoute == 'search'
                            ? Button(
                                text: _checkRequest.isRequested
                                    ? _checkRequest.type == 'temp'
                                        ? 'Already joined'
                                        : 'Cancel Request'
                                    : 'Request Offer',
                                color: _checkRequest.isRequested
                                    ? AppColors.grey
                                    : AppColors.primaryColor,
                                disabled: _checkRequest.isRequested && _checkRequest.type == 'temp',
                                onPressed: _onRequest,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

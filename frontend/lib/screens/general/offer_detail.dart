import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'waiting_request.dart';
import '../../config/themes/app_colors.dart';
import '../../config/routes/routes.dart';
import '../../models/car_info.dart';
import '../../models/schedule.dart';
import '../../models/response/common/info_response.dart';
import '../../models/response/check_request_response.dart';
import '../../services/rest/party_api.dart';
import '../../services/provider/schedule_provider.dart';
import '../../services/provider/car_information_provider.dart';
import '../../widgets/offer_detail/detail_section.dart';
import '../../widgets/common/alert_dialog.dart';
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
  bool _isPageLoading = true;
  bool _isRequesting = false;

  late CheckRequestResponse _checkRequest;
  late Schedule _schedule;
  late CarInfo _carInfo;

  Future<void> _onCancelRequest() async {
    final result = await PartyApi.deleteCancelRequest(_schedule.partyId);
    if (result is InfoResponse) {
      setState(() {
        _isRequesting = false;
        _checkRequest.isRequested = false;
        _checkRequest.type = null;
      });

      showAlertDialog(context, result.message!, success: result.success);
    } else {
      setState(() => _isRequesting = false);
      showAlertDialog(context, result.message);
    }
  }

  Future<void> _onSendRequest() async {
    final result = await PartyApi.postSendRequest(_schedule.partyId);
    if (result is InfoResponse) {
      setState(() {
        _isRequesting = false;
        _checkRequest.isRequested = true;
        _checkRequest.type = 'pending';
      });

      await Navigator.of(context).pushNamed(
        Routes.waiting,
        arguments: WaitingRequestScreenArguments(_schedule.partyId),
      );

      setState(() {
        _checkRequest.isRequested = false;
        _checkRequest.type = null;
      });
    } else {
      setState(() => _isRequesting = false);
      showAlertDialog(context, result.message);
    }
  }

  void _onRequest() {
    setState(() => _isRequesting = true);

    if (_checkRequest.isRequested) {
      _onCancelRequest();
    } else {
      _onSendRequest();
    }
  }

  Future<void> _onLoadPage(String route, int scheduleId) async {
    switch (route) {
      case 'search':
        _schedule =
            context.read<ScheduleProvider>().getSearchScheduleById(scheduleId);
        _carInfo = context
            .read<CarInfoProvider>()
            .getSearchCarInfoById(_schedule.party.driverId);
        break;
      case 'home':
        _schedule = context
            .read<ScheduleProvider>()
            .getAppointmentScheduleById(scheduleId);
        _carInfo = context
            .read<CarInfoProvider>()
            .getAppointmentCarInfoById(_schedule.party.driverId);
        break;
      case 'history':
        _schedule =
            context.read<ScheduleProvider>().getHistoryScheduleById(scheduleId);
        _carInfo = context
            .read<CarInfoProvider>()
            .getHistoryCarInfoById(_schedule.party.driverId);
        break;
    }

    if (context.read<ScheduleProvider>().selectedRoute == 'search') {
      final result = await PartyApi.getIsRequested(_schedule.partyId);
      if (result is CheckRequestResponse) {
        setState(() {
          _checkRequest = result;
          _isPageLoading = false;
        });
      } else {
        showAlertDialog(context, result.message)
            .then((_) => Navigator.pop(context));
      }
    } else {
      setState(() {
        _isPageLoading = false;
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
      body: _isPageLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  AddressBar(_schedule.destinationLocation.address),
                  Map(_schedule.startLocation, _schedule.destinationLocation),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
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
                        ProfileSection(
                          firstname: _schedule.party.driver.firstname,
                          lastname: _schedule.party.driver.lastname,
                          gender: _schedule.party.driver.gender,
                          age: _schedule.party.driver.age.toString(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: DetailSection(_schedule, _carInfo),
                        ),
                        context.read<ScheduleProvider>().selectedRoute ==
                                'search'
                            ? _isRequesting
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Button(
                                    text: _checkRequest.isRequested
                                        ? _checkRequest.type == 'pending'
                                            ? 'Cancel Request'
                                            : 'Already joined'
                                        : 'Request Offer',
                                    color: _checkRequest.isRequested
                                        ? AppColors.grey
                                        : AppColors.primaryColor,
                                    disabled: _checkRequest.isRequested &&
                                        _checkRequest.type != 'pending',
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

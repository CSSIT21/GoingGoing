import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/routes/routes.dart';
import '../../models/google_api/place.dart';
import '../../models/schedule.dart';
import '../../models/car_info.dart';
import '../../models/home/card_info.dart';
import '../../services/provider/search_provider.dart';
import '../../services/rest/schedule_api.dart';
import '../../services/provider/car_information_provider.dart';
import '../../services/provider/schedule_provider.dart';
import '../../widgets/show_offer/offer_title.dart';
import '../../widgets/common/default_card.dart';
import '../../widgets/common/offer_card.dart';
import '../../widgets/common/back_appbar.dart';
import '../../widgets/show_offer/search_result_bar.dart';

class ShowOfferScreen extends StatefulWidget {
  const ShowOfferScreen({Key? key}) : super(key: key);

  @override
  State<ShowOfferScreen> createState() => _ShowOfferScreenState();
}

class _ShowOfferScreenState extends State<ShowOfferScreen> {
  late List<Schedule> _schedules;
  late List<CarInfo> _carInfoList;
  bool _isLoading = true;

  Future<void> _onFilter() async {
    var result = await Navigator.pushNamed(context, Routes.filter);

    if (result == false) return;

    if (result != null) {
      setState(() {
        _schedules = result as List<Schedule>;
      });
    } else {
      setState(() {
        _schedules = context.read<ScheduleProvider>().searchSchedules;
      });
    }
  }

  Future<void> _fetchSchedule(Place place) async {
    final data =
        await ScheduleApi.getSearchSchedule(context, place.name, place.address);

    if (data != null) {
      context.read<ScheduleProvider>().searchSchedules = data.schedules;
      context.read<CarInfoProvider>().searchCarInfoList = data.carInfoList;

      setState(() {
        _schedules = data.schedules;
        _carInfoList = data.carInfoList;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSchedule(context.read<SearchProvider>().place);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: SearchResultBar(_onFilter),
          ),
          const OfferTitle(),
          _isLoading
              ? Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const Center(child: CircularProgressIndicator()),
                )
              : _schedules.isEmpty || _carInfoList.isEmpty
                  ? const DefaultCard(text: "No offer found")
                  : Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 20),
                        itemBuilder: (context, index) => OfferCard(
                          info: OfferCardInfo(
                            _schedules[index],
                            _carInfoList
                                .firstWhere((el) =>
                                    el.ownerId ==
                                    _schedules[index].party.driverId)
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

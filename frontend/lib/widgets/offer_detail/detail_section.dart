import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/themes/app_colors.dart';
import '../../models/car_info.dart';
import '../../models/schedule.dart';
import 'text_with_icon.dart';

class DetailSection extends StatelessWidget {
  final Schedule schedule;
  final CarInfo carInfo;

  const DetailSection(this.schedule, this.carInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _filter = schedule.filter.getFilterNames(true).join(', ');
    final _carInfo = '${carInfo.carColor}, ${carInfo.carBrand}';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 16),
          child: Text(
            'Details',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.left,
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWithIcon(
                    icon: Icons.calendar_today,
                    text: DateFormat('dd-MM-yyyy').format(schedule.startTripDateTime),
                  ),
                  TextWithIcon(
                    icon: Icons.person,
                    text: '${schedule.party.maximumPassengers} Person',
                  ),
                  TextWithIcon(
                    icon: Icons.directions_car,
                    text: carInfo.carRegis,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWithIcon(
                    icon: Icons.access_time,
                    text: DateFormat.jm().format(schedule.startTripDateTime),
                  ),
                  Tooltip(
                    message: _filter,
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(12),
                    textStyle:
                        Theme.of(context).textTheme.subtitle1?.copyWith(color: AppColors.white),
                    decoration: BoxDecoration(
                      color: AppColors.blackGrey.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    preferBelow: false,
                    child: TextWithIcon(
                      icon: Icons.filter_list,
                      text: _filter,
                    ),
                  ),
                  Tooltip(
                    message: _carInfo,
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(12),
                    textStyle:
                        Theme.of(context).textTheme.subtitle1?.copyWith(color: AppColors.white),
                    decoration: BoxDecoration(
                      color: AppColors.blackGrey.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    preferBelow: false,
                    child: TextWithIcon(
                      icon: Icons.info,
                      text: _carInfo,
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

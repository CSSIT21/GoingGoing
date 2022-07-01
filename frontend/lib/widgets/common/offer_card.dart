import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/provider/schedule_provider.dart';
import '../../config/routes/routes.dart';
import '../../config/themes/app_colors.dart';
import '../../models/home/card_info.dart';
import '../../screens/general/offer_detail.dart';
import '../home/info_box.dart';

class OfferCard extends StatelessWidget {
  final OfferCardInfo info;
  final String pageName;

  const OfferCard({Key? key, required this.info, required this.pageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 32),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0), side: BorderSide.none),
      child: InkWell(
        onTap: () {
          context.read<ScheduleProvider>().selectedId = info.scheduleId;
          Navigator.pushNamed(
            context,
            Routes.offerDetail,
            arguments: OfferDetailArguments(pageName),
          );
        },
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          padding: const EdgeInsets.only(left: 28, right: 28, top: 18, bottom: 14),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.grey.withOpacity(0.2),
                blurRadius: 10.0,
                spreadRadius: 6,
                offset: const Offset(
                  3, // Move to right 10  horizontally
                  6.0, // Move to bottom 10 Vertically
                ),
              ),
            ],
            borderRadius: BorderRadius.circular(16.0),
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor,
                AppColors.primaryColor.withOpacity(0.2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                info.name,
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 14,
              ),
              InfoBox(
                date: info.date,
                time: info.time,
                partySize: info.partySize,
                carRegistration: info.carRegistration,
                address: info.address,
              )
            ],
          ),
        ),
      ),
    );
  }
}

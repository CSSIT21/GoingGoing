import 'package:going_going_frontend/services/provider/schedule_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:going_going_frontend/constants/assets_path.dart';
import 'package:going_going_frontend/widgets/common/close_app_bar.dart';
import 'package:going_going_frontend/widgets/end_ride/price_text.dart';

class EndRideScreen extends StatelessWidget {
  const EndRideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedId = context.read<ScheduleProvider>().selectedId;
    final schedule = context.read<ScheduleProvider>().getAppointmentScheduleById(selectedId);
    final distance = schedule.distance;
    final numberOfPassengers = schedule.party.passengerIds.length;


    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CloseAppBar(
            title: "Your Trip Cost",
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(
            height: 80,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 180,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(AssetsConstants.endRide),
              ),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          Container(
            padding: const EdgeInsets.only(left: 56),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 16,
                ),
                PriceText(price: (distance * 35.00).toString()),
                const SizedBox(
                  height: 65,
                ),
                Text(
                  "Your Price",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Share with $numberOfPassengers friends',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const SizedBox(
                  height: 15,
                ),
                PriceText(price: ((distance * 35.00) / numberOfPassengers).toString()),
              ],
            ),
          )
        ],
      ),
    );
  }
}

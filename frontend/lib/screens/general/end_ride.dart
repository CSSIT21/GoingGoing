import 'package:flutter/material.dart';
import 'package:going_going_frontend/constants/assets_path.dart';
import 'package:going_going_frontend/widgets/common/close_app_bar.dart';
import 'package:going_going_frontend/widgets/end_ride/price_text.dart';


class EndRideScreen extends StatefulWidget {
  final double total;
  final int partySize;
  const EndRideScreen({Key? key, required this.total, required this.partySize}) : super(key: key);

  @override
  State<EndRideScreen> createState() => _EndRideScreenState();
}

class _EndRideScreenState extends State<EndRideScreen> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CloseAppBar(title: "Your Trip Cost"),
            // FittedBox(
            //   child: Image.asset(AssetsConstants.endRide),
            //   fit: BoxFit.fill,
            // ),

            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: 174,
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       fit: BoxFit.fill,
            //       image: AssetImage(AssetsConstants.endRide),
            //     ),
            //   ),
            // ),

            const SizedBox(
              height: 70,
            ),
            Image.asset(
              AssetsConstants.endRide,
              fit: BoxFit.contain,
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
                  PriceText(price: widget.total.toString()),

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
                    'Share with ${widget.partySize} friends',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  PriceText(price: (widget.total / widget.partySize).toString()),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}



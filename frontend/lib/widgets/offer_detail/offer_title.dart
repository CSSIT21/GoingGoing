import 'package:flutter/material.dart';

class OfferTitle extends StatelessWidget {
  const OfferTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 35),
      child: Text(
        'Offers',
        style: Theme.of(context).textTheme.headline1,
        textAlign: TextAlign.start,
      ),
    );
  }
}

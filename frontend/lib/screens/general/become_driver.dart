import 'package:flutter/material.dart';
import 'package:going_going_frontend/widgets/common/back_appbar.dart';
import 'package:going_going_frontend/widgets/common/label_textfield.dart';

import '../../widgets/common/button.dart';

class BecomeDriverScreen extends StatefulWidget {
  const BecomeDriverScreen({Key? key}) : super(key: key);

  @override
  State<BecomeDriverScreen> createState() => _BecomeDriverScreenState();
}

class _BecomeDriverScreenState extends State<BecomeDriverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(title: 'Become a Driver'),
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
        child: Column(
          children: [
            const SizedBox(
              height: 56,
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Enter Your Car Details',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.start,
                )),
            const SizedBox(height: 32),
            const LabelTextField(
                hintText: 'Enter car registration',
                labelText: 'Car Registration'),
            const LabelTextField(
                hintText: 'Enter car color', labelText: 'Color'),
            const LabelTextField(
                hintText: 'Enter car brand', labelText: 'Brand'),
            const SizedBox(height: 8),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Please send other required documents to GoingGoing@gmail.com We’ll contact you after your request is approved.',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(fontSize: 9 , color: Colors.grey),
              ),
            ),
            const SizedBox(height: 96),
            Button(text: 'Confirm', onPressed: () {}),
          ],
        ),
        
      ),
    );
  }
}

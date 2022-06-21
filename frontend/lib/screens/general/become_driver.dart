import 'package:flutter/material.dart';
import 'package:going_going_frontend/services/provider/car_informations_provider.dart';
import 'package:going_going_frontend/widgets/common/back_appbar.dart';
import 'package:going_going_frontend/widgets/common/label_textfield.dart';
import 'package:provider/provider.dart';

import '../../widgets/common/button.dart';

class BecomeDriverScreen extends StatefulWidget {
  const BecomeDriverScreen({Key? key}) : super(key: key);

  @override
  State<BecomeDriverScreen> createState() => _BecomeDriverScreenState();
}

class _BecomeDriverScreenState extends State<BecomeDriverScreen> {
  final _formkey = GlobalKey<FormState>();
  final _carRegisController = TextEditingController();
  final _carColorController = TextEditingController();
  final _carBrandController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carRegisController.text = context.read<CarInfoProvider>().carRegis;
    _carBrandController.text = context.read<CarInfoProvider>().carBrand;
    _carColorController.text = context.read<CarInfoProvider>().carColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(title: 'Become a Driver'),
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter Your Car Details',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.start,
                  )),
              const SizedBox(height: 32),
              LabelTextField(
                hintText: 'Enter car registration',
                labelText: 'Car Registration',
                controller: _carRegisController,
                validator: (value) {
                  String pattern = r'(^[A-Za-z]{2}-[0-9]{4}$)';
                  RegExp regexp = RegExp(pattern);
                  if (value == null || value.isEmpty) {
                    return 'Required*';
                  } else if (!regexp.hasMatch(value)) {
                    return 'Your car registeration format is incorrect';
                  }
                  return null;
                },
              ),
              LabelTextField(
                hintText: 'Enter car color',
                labelText: 'Color',
                controller: _carColorController,
              ),
              LabelTextField(
                hintText: 'Enter car brand',
                labelText: 'Brand',
                controller: _carBrandController,
              ),
              const SizedBox(height: 8),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Please send other required documents to GoingGoing@gmail.com We’ll contact you after your request is approved.',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontSize: 9, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 96),
              Button(text: 'Confirm', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

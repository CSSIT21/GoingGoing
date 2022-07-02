import 'package:flutter/material.dart';
import 'package:going_going_frontend/services/provider/car_informations_provider.dart';
import 'package:going_going_frontend/widgets/common/back_appbar.dart';
import 'package:going_going_frontend/widgets/common/label_textfield.dart';
import 'package:provider/provider.dart';

import '../../services/rest/profile_api.dart';
import '../../widgets/common/button.dart';

class BecomeDriverScreen extends StatefulWidget {
  const BecomeDriverScreen({Key? key}) : super(key: key);

  @override
  State<BecomeDriverScreen> createState() => _BecomeDriverScreenState();
}

class _BecomeDriverScreenState extends State<BecomeDriverScreen> {
  final _formkey = GlobalKey<FormState>();
  late TextEditingController _carRegisController = TextEditingController();
  late TextEditingController _carColorController = TextEditingController();
  late TextEditingController _carBrandController = TextEditingController();
  final _diverBtnController = TextEditingController();
  bool isSubmit = false;

  @override
  void initState() {
    super.initState();
    ProfileApi.getDriverProfile(context);
    //_carRegisController.text = context.read<CarInfoProvider>().userCarInfo.carRegis;
    setState(() {
      _carRegisController = TextEditingController(
          text: context.read<CarInfoProvider>().userCarInfo.carRegis);
      _carBrandController = TextEditingController(
          text: context.read<CarInfoProvider>().userCarInfo.carBrand);
      _carColorController = TextEditingController(
          text: context.read<CarInfoProvider>().userCarInfo.carColor);
    });

    //_carColorController.text = context.read<CarInfoProvider>().userCarInfo.carColor;
  }

  @override
  void dispose() {
    _carRegisController.dispose();
    _carColorController.dispose();
    _carBrandController.dispose();
    super.dispose();
  }

  Future<void> handleUpdateDriver() async {
    setState(() {
      isSubmit = true;
    });
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      isSubmit = false;
      var carRegis = context.read<CarInfoProvider>().userCarInfo.carRegis;
      var carBrand = context.read<CarInfoProvider>().userCarInfo.carBrand;
      var carColor = context.read<CarInfoProvider>().userCarInfo.carColor;
      debugPrint(_carRegisController.text);
      debugPrint(_carBrandController.text);
      debugPrint(_carColorController.text);
      if (carRegis != "" && carBrand != "" && carColor != "") {
        ProfileApi.updateDriverProfile(_carRegisController.text,
            _carBrandController.text, _carColorController.text, context);
        debugPrint("------------updated 1-----------");
      } else {
        ProfileApi.postDriverProfile(_carRegisController.text,
            _carBrandController.text, _carColorController.text, context);
      }

    }
    _diverBtnController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(title: 'Become a Driver'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
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
                    return 'Your car registration is not EX-000 format.';
                  }
                  return null;
                },
              ),
              LabelTextField(
                hintText: 'Enter car color',
                labelText: 'Color',
                controller: _carColorController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required*';
                  }
                  return null;
                },
              ),
              LabelTextField(
                hintText: 'Enter car brand',
                labelText: 'Brand',
                controller: _carBrandController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required*';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '''Please send other required documents to GoingGoing@gmail.com 
                    We'll contact you after your request is approved.''',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontSize: 9, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 96),
              Button(text: 'Confirm', onPressed: handleUpdateDriver),
            ],
          ),
        ),
      ),
    );
  }
}

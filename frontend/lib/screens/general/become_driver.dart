import 'package:flutter/material.dart';
import 'package:going_going_frontend/services/provider/car_information_provider.dart';
import 'package:going_going_frontend/widgets/common/back_appbar.dart';
import 'package:going_going_frontend/widgets/common/label_text_field.dart';
import 'package:provider/provider.dart';

import '../../services/rest/profile_api.dart';
import '../../widgets/common/button.dart';

class BecomeDriverScreen extends StatefulWidget {
  const BecomeDriverScreen({Key? key}) : super(key: key);

  @override
  State<BecomeDriverScreen> createState() => _BecomeDriverScreenState();
}

class _BecomeDriverScreenState extends State<BecomeDriverScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _carRegisController;
  late TextEditingController _carColorController;
  late TextEditingController _carBrandController;
  bool isSubmit = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    ProfileApi.getDriverProfile(context);
    setState(() {
      _carRegisController = TextEditingController(
          text: context.read<CarInfoProvider>().userCarInfo.carRegis);
      _carBrandController = TextEditingController(
          text: context.read<CarInfoProvider>().userCarInfo.carBrand);
      _carColorController = TextEditingController(
          text: context.read<CarInfoProvider>().userCarInfo.carColor);
      _isLoading = false;
    });
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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        isSubmit = false;
      });
      var carRegis = context.read<CarInfoProvider>().userCarInfo.carRegis;
      var carBrand = context.read<CarInfoProvider>().userCarInfo.carBrand;
      var carColor = context.read<CarInfoProvider>().userCarInfo.carColor;
      if (carRegis != "" && carBrand != "" && carColor != "") {
        ProfileApi.updateDriverProfile(_carRegisController.text,
            _carBrandController.text, _carColorController.text, context);
      } else {
        ProfileApi.postDriverProfile(_carRegisController.text,
            _carBrandController.text, _carColorController.text, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(title: 'Become a Driver'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Form(
                key: _formKey,
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

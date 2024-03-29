import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../constants/assets_path.dart';
import '../../config/routes/routes.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_theme.dart';
import '../../services/rest/account_api.dart';
import '../../widgets/common/date_picker_field.dart';
import '../../widgets/common/dropdown_field.dart';
import '../../widgets/common/button.dart';
import '../../widgets/common/label_text_field.dart';
import '../../widgets/common/password_field.dart';
import '../../widgets/login/login_title.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TapGestureRecognizer _recognizer;
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final List<String> _genders = const ['Male', 'Female'];
  DateTime _birthDate = DateTime.now();
  String _selectedGender = "Male";

  void _onPickedDate(DateTime picked) {
    setState(() {
      _birthDate = picked;
    });
  }

  void _onSelectedGender(String gender) {
    setState(() {
      _selectedGender = gender;
    });
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String dateTimeString = _birthDate.toIso8601String().substring(0, 23) + "Z";

      AccountApi.register(
          _phoneNumberController.text,
          _passwordController.text,
          _firstnameController.text,
          _lastnameController.text,
          dateTimeString,
          _selectedGender,
          context);
    }
  }

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushReplacementNamed(context, Routes.login);
      };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsConstants.background),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 128, left: 32, bottom: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[LoginTitle(titleText: 'Sign Up')],
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  height: MediaQuery.of(context).size.height * 1.05,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LabelTextField(
                          hintText: 'Enter your phone number',
                          labelText: 'Phone Number',
                          validator: (value) {
                            String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
                            RegExp regexp = RegExp(pattern);
                            if (value == null || value.isEmpty) {
                              return 'Required*';
                            } else if (!regexp.hasMatch(value)) {
                              return 'Your phone number format is incorrect';
                            }
                            return null;
                          },
                          controller: _phoneNumberController,
                        ),
                        PasswordField(
                          controller: _passwordController,
                        ),
                        LabelTextField(
                          hintText: 'Enter your firstname',
                          labelText: 'Firstname',
                          controller: _firstnameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required*';
                            }
                            return null;
                          },
                        ),
                        LabelTextField(
                          hintText: 'Enter your lastname',
                          labelText: 'Lastname',
                          controller: _lastnameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required*';
                            }
                            return null;
                          },
                        ),
                        DatePickerField(
                          labelText: 'Date',
                          pickedDate: _birthDate,
                          onPickedDate: _onPickedDate,
                        ),
                        DropdownField(
                          hintText: 'Select your gender',
                          labelText: 'Gender',
                          selectedValue: _selectedGender,
                          list: _genders,
                          onChanged: _onSelectedGender,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 32, bottom: 46),
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              style: AppTextTheme.textTheme.subtitle1,
                              children: <TextSpan>[
                                const TextSpan(
                                    text: "Already have an account? ",
                                    style: TextStyle(color: Colors.grey)),
                                TextSpan(
                                  text: "Log In",
                                  style: const TextStyle(
                                    color: AppColors.secondaryColor,
                                  ),
                                  recognizer: _recognizer,
                                )
                              ],
                            ),
                          ),
                        ),
                        Button(
                          text: 'Sign Up',
                          onPressed: _handleRegister,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

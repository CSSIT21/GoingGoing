import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../config/routes/routes.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_theme.dart';
import '../../constants/assets_path.dart';
import '../../services/rest/account_api.dart';
import '../../widgets/common/button.dart';
import '../../widgets/common/label_text_field.dart';
import '../../widgets/common/password_field.dart';
import '../../widgets/login/login_title.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TapGestureRecognizer _recognizer;
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AccountApi.login(
          _phoneNumberController.text, _passwordController.text, context);
    }
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _recognizer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.popAndPushNamed(context, Routes.signUp);
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
                  padding:
                      const EdgeInsets.only(top: 128, left: 32, bottom: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[LoginTitle(titleText: 'Log In')],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 32, left: 32, right: 32),
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
                          Container(
                            margin: const EdgeInsets.only(top: 32, bottom: 46),
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                  style: AppTextTheme.textTheme.subtitle1,
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: "New Here? Create an account  ",
                                        style: TextStyle(color: Colors.grey)),
                                    TextSpan(
                                        text: "Sign Up",
                                        style: const TextStyle(
                                          color: AppColors.secondaryColor,
                                        ),
                                        recognizer: _recognizer)
                                  ]),
                            ),
                          ),
                          Button(text: 'Log In', onPressed: _handleLogin),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

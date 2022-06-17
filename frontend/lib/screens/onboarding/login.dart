import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/assets_path.dart';
import '../../config/routes/routes.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_theme.dart';
import '../../widgets/common/button.dart';
import '../../widgets/common/label_textfield.dart';
import '../../widgets/common/password_field.dart';
import '../../widgets/login/login_title.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TapGestureRecognizer _recognizer;
  final _formkey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    getSharedPreference();
    super.initState();
    _recognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.popAndPushNamed(context, Routes.signUp);
      };
  }

  getSharedPreference() async {
    var prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //background Image
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
                  key: _formkey,
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
                          Button(text: 'Log In', onPressed: () {}),
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

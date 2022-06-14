import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/themes/app_colors.dart';
import 'package:going_going_frontend/config/themes/app_text_theme.dart';
import 'package:going_going_frontend/widgets/common/label_textfield.dart';
import 'package:going_going_frontend/widgets/common/password_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> { 
  
  @override
  Widget build(BuildContext context) {
    //่ีnow only use for display while editing components
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 128, left: 32, bottom: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: const Text(
                        'Log In',
                        style: TextStyle(fontSize: 36),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Column(
                    children: [
                      const LabelTextField(
                          hintText: 'Enter your phone number',
                          labelText: 'Phone Number'),
                      const PasswordField(),
                      const SizedBox(
                        height: 32,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                              style: AppTextTheme.textTheme.subtitle1,
                              children:  const <TextSpan>[
                                TextSpan(
                                    text: "New Here? Create an account  ",
                                    style: TextStyle(color: Colors.grey)),
                                TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                      color: AppColors.secondaryColor,
                                    ),
                                  )
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ]),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:going_going_frontend/widgets/common/date_picker_field.dart';
import 'package:going_going_frontend/widgets/common/dropdown_field.dart';
import '../../config/routes/routes.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_theme.dart';
import '../../widgets/common/label_textfield.dart';
import '../../widgets/common/password_field.dart';
import '../../widgets/login/login_title.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
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
                    children: const <Widget>[LoginTitle(titleText: 'Sign Up')],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 1,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const LabelTextField(
                            hintText: 'Enter your phone number',
                            labelText: 'Phone Number'),
                        const PasswordField(),
                        const LabelTextField(
                            hintText: 'Enter your firstname',
                            labelText: 'Firstname'),
                        const LabelTextField(
                            hintText: 'Enter your lastname',
                            labelText: 'Lastname'),
                        const DatePickerField(labelText:'Date'),
                        const DropdownField(hintText: 'Select your gender', labelText: 'Gender'),
                        const SizedBox(
                          height: 32,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                                style: AppTextTheme.textTheme.subtitle1,
                                children:  <TextSpan>[
                                  const TextSpan(
                                      text: "Already have an account? ",
                                      style: TextStyle(color: Colors.grey)),
                                  TextSpan(
                                    text: "Log In",
                                    style: const TextStyle(
                                      color: AppColors.secondaryColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.popAndPushNamed(
                                              context, Routes.login);
                                        })
                                ]),
                          ),
                        ),
                        
                        //Add Button

                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:going_going_frontend/widgets/common/password_field.dart';

import '../../widgets/common/label_textfield.dart';

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
        body: Column(
      children: const [
        LableTextField(
            hintText: 'Enter your phone number', lableText: 'Phone Number'),
        PasswordField()
      ],
    ));
  }
}

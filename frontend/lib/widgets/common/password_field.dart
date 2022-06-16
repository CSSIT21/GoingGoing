import 'package:flutter/material.dart';
import '../../config/themes/app_colors.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;

  
  const PasswordField({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Password',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              } else if (value.length < 8) {
                return 'Your password length is incorrect';
              }
              return null;
            },
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.primaryColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300)),
              hintText: 'Enter your password',
            ),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}

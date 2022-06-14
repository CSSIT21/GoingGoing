import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class LableTextField extends StatelessWidget {
  final String lableText;
  final String hintText;

  const LableTextField(
      {Key? key,
      required this.hintText,
      required this.lableText,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 32, right: 32, top: 18, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
            child: Text(
              lableText,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter this field';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.primaryColor)),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: hintText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

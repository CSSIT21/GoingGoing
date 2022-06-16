import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class DropdownField extends StatefulWidget {
  final String labelText;
  final String hintText;

  const DropdownField({
    required this.hintText,
    required this.labelText,
    Key? key,
  }) : super(key: key);

  @override
  _DropdownFieldState createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  List<String> gender = ['Select', 'Male', 'Female'];
  String? selectedItem = 'Select';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 0, right: 0, top: 18, bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 8),
            child: Text(
              widget.labelText,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(
            //width: 480,
            height: 48,
            child: DropdownButtonFormField<String>(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a transaction type';
                }
                return null;
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:  BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.primaryColor)),
              ),
              isDense: true,
              value: selectedItem,
              hint: Text(widget.hintText),
              isExpanded: true,
              items: gender.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedItem = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

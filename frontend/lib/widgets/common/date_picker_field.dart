import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../config/themes/app_colors.dart';
import '../../services/provider/user_provider.dart';

class DatePickerField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;

  const DatePickerField({required this.labelText, Key? key, required this.controller,}) : super(key: key);
  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime? pickedDate;
  String? formattedDate;

  @override
  void initState() {
    widget.controller.text = DateFormat('dd-MM-yyyy').format(context.read<UserProvider>().birthdate);
    formattedDate = DateTime.now().toIso8601String().substring(0, 20) + "000Z";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 8),
            child: Text(
              widget.labelText,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == "" || value!.isEmpty) {
                return 'Please select date';
              }
              return null;
            },
            controller: widget.controller,
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.calendar_today),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.primaryColor)),
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now());
              if (pickedDate != null) {
                formattedDate = pickedDate.toIso8601String().substring(0, 20) + "000Z";
                String formattedDateShow = DateFormat('dd-MM-yyyy').format(pickedDate);
                setState(() {
                  widget.controller.text = formattedDateShow;
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
        ],
      ),
    );
  }
}

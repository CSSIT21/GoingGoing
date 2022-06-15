import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/themes/app_colors.dart';

class DatePickerField extends StatefulWidget {
  final String labelText;

  const DatePickerField({required this.labelText});
  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  final _dateKey = TextEditingController();
  DateTime? pickedDate;
  String? formattedDate;

  @override
  void initState() {
    _dateKey.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    formattedDate = DateTime.now().toIso8601String().substring(0, 20) + "000Z";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 32, right: 32, top: 18, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 8),
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
            controller: _dateKey,
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.calendar_today),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: AppColors.primaryColor)),
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now());
              if (pickedDate != null) {
                formattedDate =
                    pickedDate.toIso8601String().substring(0, 20) + "000Z";
                String formattedDateShow =
                    DateFormat('dd-MM-yyyy').format(pickedDate);
                setState(() {
                  _dateKey.text = formattedDateShow;
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
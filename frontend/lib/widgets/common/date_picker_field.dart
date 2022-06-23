import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/themes/app_colors.dart';

class DatePickerField extends StatefulWidget {
  final String labelText;
  final DateTime pickedDate;
  final Function onPickedDate;

  const DatePickerField({
    required this.labelText,
    required this.pickedDate,
    required this.onPickedDate,
    Key? key,
  }) : super(key: key);

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  late final TextEditingController _dateController = TextEditingController(
    text: DateFormat('dd-MM-yyyy').format(widget.pickedDate),
  );

  void _onPickdate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.pickedDate,
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != widget.pickedDate) {
      widget.onPickedDate(picked);
      _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
    } else {
      debugPrint("Date is not selected");
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              widget.labelText,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
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
            controller: _dateController,
            style: Theme.of(context).textTheme.bodyText2,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
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
            onTap: _onPickdate,
          ),
        ],
      ),
    );
  }
}

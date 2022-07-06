import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../config/themes/app_colors.dart';

class DatePickerField extends StatefulWidget {
  final String labelText;
  final Function onPickedDate;
  final DateTime? pickedDate;
  final DateTime? lastDate;

  const DatePickerField({
    required this.labelText,
    required this.onPickedDate,
    this.lastDate,
    this.pickedDate,
    Key? key,
  }) : super(key: key);

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  late final TextEditingController _dateController = TextEditingController();

  Future<void> _onPickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.pickedDate ?? DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: widget.lastDate ?? DateTime.now(),
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
    _dateController.text = widget.pickedDate == null
        ? 'Select date'
        : DateFormat('dd-MM-yyyy').format(widget.pickedDate!);

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
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: widget.pickedDate == null ? AppColors.blackGrey : AppColors.black),
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
            onTap: _onPickDate,
          ),
        ],
      ),
    );
  }
}

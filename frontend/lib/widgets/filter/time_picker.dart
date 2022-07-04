import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class TimePicker extends StatefulWidget {
  final String labelText;
  final TimeOfDay? pickedTime;
  final Function onPickedTime;

  const TimePicker({
    required this.labelText,
    required this.pickedTime,
    required this.onPickedTime,
    Key? key,
  }) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late final TextEditingController _timeController = TextEditingController();

  Future<void> _onPickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: widget.pickedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != widget.pickedTime) {
      widget.onPickedTime(picked);
      _timeController.text = picked.format(context);
    } else {
      debugPrint("Time is not selected");
    }
  }

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _timeController.text = widget.pickedTime == null
        ? 'Select time'
        : TimeOfDay(
            hour: widget.pickedTime!.hour,
            minute: widget.pickedTime!.minute,
          ).format(context);

    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 18.0),
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
            controller: _timeController,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: widget.pickedTime == null
                    ? AppColors.blackGrey
                    : AppColors.black),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
              suffixIcon: const Icon(Icons.access_time),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.primaryColor)),
            ),
            readOnly: true,
            onTap: _onPickTime,
          ),
        ],
      ),
    );
  }
}

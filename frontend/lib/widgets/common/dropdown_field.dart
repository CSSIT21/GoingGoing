import 'package:flutter/material.dart';
import '../../config/themes/app_colors.dart';

class DropdownField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String selectedValue;
  final List<String> list;
  final Function onChanged;

  const DropdownField({
    required this.hintText,
    required this.labelText,
    required this.selectedValue,
    required this.list,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _DropdownFieldState createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              widget.labelText,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
          DropdownButtonFormField<String>(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty || value == "Select") {
                return 'Please select this field';
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.primaryColor)),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
            value: widget.selectedValue,
            hint: Text(
              widget.hintText,
              style: const TextStyle(height: 0),
            ),
            isExpanded: true,
            items: widget.list.map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                widget.onChanged(value);
              }
            },
          ),
        ],
      ),
    );
  }
}

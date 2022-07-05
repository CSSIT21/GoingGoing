import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class TypeChips extends StatefulWidget {
  final String selectedChoice = "Schedule";
  final Function setSelectedChoice;

  const TypeChips(
      {Key? key, required selectedChoice, required this.setSelectedChoice})
      : super(key: key);

  @override
  State<TypeChips> createState() => _TypeChipsState();
}

class _TypeChipsState extends State<TypeChips> {
  String _selectedChoice = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedChoice = widget.selectedChoice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 32),
        child: Wrap(
          spacing: 5.0,
          runSpacing: 5.0,
          children: <Widget>[
            Wrap(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: ChoiceChip(
                    shadowColor: Colors.transparent,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 11),
                    label: const Text("Schedule"),
                    labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: _selectedChoice == "Schedule"
                              ? AppColors.secondaryColor
                              : AppColors.blackGrey,
                          fontWeight: _selectedChoice == "Schedule"
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    backgroundColor: Colors.white,
                    selectedColor: AppColors.primaryColor.withOpacity(0.2),
                    selected: _selectedChoice == "Schedule",
                    onSelected: (selected) {
                      setState(() {
                        _selectedChoice = "Schedule";
                        widget.setSelectedChoice("Schedule");
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: ChoiceChip(
                    shadowColor: Colors.transparent,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 11),
                    label: const Text("History"),
                    labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: _selectedChoice == "History"
                              ? AppColors.secondaryColor
                              : AppColors.blackGrey,
                          fontWeight: _selectedChoice == "History"
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    backgroundColor: Colors.white,
                    selectedColor: AppColors.primaryColor.withOpacity(0.2),
                    selected: _selectedChoice == "History",
                    onSelected: (selected) {
                      setState(() {
                        _selectedChoice = "History";
                      });
                      widget.setSelectedChoice("History");
                    },
                  ),
                )
              ],
            )
          ],
        ));
  }
}

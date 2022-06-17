import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/themes/app_colors.dart';

class TypeChips extends StatefulWidget {
  final String selectedChoice = "Schedule";
  final Function setSelectedChoice;
  const TypeChips({Key? key,required selectedChoice, required this.setSelectedChoice}) : super(key: key);

  @override
  State<TypeChips> createState() => _TypeChipsState();
}

class _TypeChipsState extends State<TypeChips> {
  String selectedChoice = "";

  @override
  void initState() {
    super.initState();
    setState(() {
       selectedChoice = widget.selectedChoice;
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 11),
                    label: const Text("Schedule"),
                    labelStyle: TextStyle(
                        color: selectedChoice == "Schedule"
                            ? AppColors.secondaryColor
                            : AppColors.grey2,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    backgroundColor: Colors.white,
                    selectedColor: const Color.fromRGBO(255, 243, 178, 100),
                    selected: selectedChoice == "Schedule",
                    onSelected: (selected) {
                      setState(() {
                        selectedChoice = "Schedule";
                        widget.setSelectedChoice("Schedule");
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: ChoiceChip(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 11),
                    label: const Text("History"),
                    labelStyle: TextStyle(
                        color: selectedChoice == "History"
                            ? AppColors.secondaryColor
                            : AppColors.grey2,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    backgroundColor: Colors.white,
                    selectedColor: const Color.fromRGBO(255, 243, 178, 100),
                    selected: selectedChoice == "History",
                    onSelected: (selected) {
                      setState(() {
                        selectedChoice = "History";
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

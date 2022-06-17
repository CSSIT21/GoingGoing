import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/themes/app_colors.dart';
import 'package:going_going_frontend/widgets/common/offer_card.dart';
import 'package:going_going_frontend/widgets/home/title_box.dart';
import 'package:going_going_frontend/widgets/home/type_chips.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedChoice = "Schedule";

  @override
  void initState() {
    super.initState();
  }

  setSelectedChoice(String choice) {
    setState(() {
      selectedChoice = choice;
    });
    debugPrint(selectedChoice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 125,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
                const TitleBox(),
                const SizedBox(
                  height: 30,
                ),
                TypeChips(
                    selectedChoice: selectedChoice,
                    setSelectedChoice: setSelectedChoice),
                const SizedBox(
                  height: 48,
                ),
              ],
            ),
            OfferCard(),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: const [OfferCard()],
            // )
          ],
        ));
  }
}

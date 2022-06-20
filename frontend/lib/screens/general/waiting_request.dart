import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/routes/routes.dart';
import 'package:going_going_frontend/config/themes/app_colors.dart';
import 'package:going_going_frontend/widgets/common/button.dart';

import '../../constants/assets_path.dart';

class WaitingRequestScreen extends StatelessWidget {
  const WaitingRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 195,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(AssetsConstants.waiting),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            '''Please wait for the driver to 
       accept your request''',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(height: 1.3),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "We’ll send you a notification!",
            style:
                Theme.of(context).textTheme.subtitle2?.copyWith(fontSize: 12),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 53),
            margin: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Button(text: "Back to Home", onPressed: () => Navigator.pushNamed(context, Routes.home)),
                const SizedBox(
                  height: 16,
                ),
                Button(text: "Cancel Request", onPressed: () {}, color: AppColors.grey,),
              ],
            ),
          )
        ],
      ),
    );
  }
}

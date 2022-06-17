import 'package:flutter/material.dart';
import 'package:going_going_frontend/widgets/home/info_text_format.dart';

class InfoBox extends StatelessWidget {
  const InfoBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const[
             InFoTextFormat(text: "23-03-2022", icon: Icons.date_range,),
             InFoTextFormat(text:  "7.00 PM", icon: Icons.access_time,),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:const [
            InFoTextFormat(text:  "3 Person", icon: Icons.person,),
            InFoTextFormat(text:  "CD-5616", icon: Icons.directions_car,),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        const InFoTextFormat(text:  "KMUTT,  Pracha Uthit Rd.", icon: Icons.place,),
      ],
    );
  }
}

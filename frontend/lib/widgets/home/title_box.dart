import 'dart:io';

import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/themes/app_colors.dart';
import 'package:going_going_frontend/config/themes/app_text_theme.dart';
import 'package:going_going_frontend/constants/assets_path.dart';
import 'package:going_going_frontend/widgets/home/type_chips.dart';

import '../../constants/assets_path.dart';

class TitleBox extends StatefulWidget {
  const TitleBox({Key? key}) : super(key: key);

  @override
  State<TitleBox> createState() => _TitleBoxState();
}

class _TitleBoxState extends State<TitleBox> {
  // var imagePath = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXiL3_iwgcv_dBebxkIiO9aMITenkWuxFtoCZZDSCzGqfiBw1TmHCsRyx5W9zeWeC2l_E&usqp=CAU";
  var imagePath = "";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
           Container(
             width: 50,
             height: 50,
            margin: const EdgeInsets.only(left: 32, right: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40.0),
              child: FadeInImage(
                  placeholder: const AssetImage(AssetsConstants.profile),
                  image: imagePath.isEmpty
                      ? NetworkImage(imagePath) :  NetworkImage(
                      imagePath)),
            ),
          ),

          Text(
            "My Activity",
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    );
  }
}

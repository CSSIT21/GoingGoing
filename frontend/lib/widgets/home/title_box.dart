import 'package:flutter/material.dart';
import 'dart:io';
import 'package:going_going_frontend/config/routes/routes.dart';
import 'package:going_going_frontend/constants/assets_path.dart';

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
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.profile);
              },
              child: Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(left: 32, right: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: FadeInImage(
                    placeholder: const AssetImage(AssetsConstants.profile),
                    image: imagePath.isEmpty
                        ? const AssetImage(AssetsConstants.profile)
                        : FileImage(File(
                                '/data/user/0/com.example.going_going_frontend/cache/$imagePath'))
                            as ImageProvider<Object>
                  ),
                ),
              )),
          Text(
            "My Activity",
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    );
  }
}

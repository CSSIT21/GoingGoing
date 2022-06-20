import 'dart:io';
import 'package:flutter/material.dart';

import '../../constants/assets_path.dart';

class ProfileSection extends StatelessWidget {
  final String firstname;
  final String lastname;
  final String gender;
  final String age;
  final String pathProfilePic;

  const ProfileSection({
    Key? key,
    required this.firstname,
    required this.lastname,
    required this.gender,
    required this.age,
    this.pathProfilePic = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 77,
          height: 77,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(500),
            child: FadeInImage(
                placeholder: const AssetImage(AssetsConstants.profile),
                image: pathProfilePic.toString().isEmpty
                    ? const AssetImage(AssetsConstants.profile)
                    : FileImage(File(
                            '/data/user/0/com.example.going_going_frontend/cache/$pathProfilePic'))
                        as ImageProvider<Object>,
                fit: BoxFit.fitWidth),
          ),
        ),
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              firstname + " " + lastname,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              gender,
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              age + " Years Old",
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ],
    );
  }
}

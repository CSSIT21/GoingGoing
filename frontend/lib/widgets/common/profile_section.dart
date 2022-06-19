import 'package:flutter/material.dart';

import '../../constants/assets_path.dart';

class ProfileSection extends StatelessWidget {
  final String firstname;
  final String lastname;
  final String gender;
  final String age;

  const ProfileSection({
    Key? key,
    required this.firstname,
    required this.lastname,
    required this.gender,
    required this.age,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(500),
          child: const FadeInImage(
              placeholder: AssetImage(AssetsConstants.profile),
              image: NetworkImage(
                  'https://featuredanimation.com/wp-content/uploads/2021/02/Princess-Anneliese-Barbe-Movies.jpg'),
              height: 80,
              width: 80,
              fit: BoxFit.fitWidth),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12)),
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

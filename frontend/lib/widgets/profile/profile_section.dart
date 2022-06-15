import 'package:flutter/material.dart';
import 'package:going_going_frontend/constants/assets_path.dart';

class ProfileSection extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String gender;
  final String age;

  ProfileSection({
    Key? key,
    required this.firstname,
    required this.lastname,
    required this.gender,
    required this.age,
  }) : super(key: key);

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 96,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(500),
              child: const FadeInImage(
                  placeholder: AssetImage(AssetsConstants.profile),
                  image: NetworkImage(
                      'https://featuredanimation.com/wp-content/uploads/2021/02/Princess-Anneliese-Barbe-Movies.jpg'),
                  height: 77,
                  width: 77,
                  fit: BoxFit.fitWidth),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.firstname + " " + widget.lastname,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                     
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.gender,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.age + " Years Old",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ],
        ));
  }
}

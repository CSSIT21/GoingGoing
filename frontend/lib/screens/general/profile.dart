import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/routes/routes.dart';
import 'package:going_going_frontend/widgets/profile/logout_option.dart';
import 'package:going_going_frontend/widgets/profile/profile_option.dart';
import 'package:going_going_frontend/widgets/profile/profile_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32),
        child: Column(
          children: [
            const SizedBox(
              height: 64,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Profile',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            const SizedBox(
              height: 42,
            ),
            ProfileSection(
                firstname: 'Barbie',
                lastname: 'Roberts',
                gender: 'Female',
                age: '35'),
            const SizedBox(
              height: 36,
            ),
            const ProfileOption(
                navigatePath: Routes.editProfile,
                optiontext: 'Edit Profile',
                preffixicon: Icons.edit),
            const SizedBox(
              height: 24,
            ),
            const ProfileOption(
                navigatePath: Routes.becomeDriver,
                optiontext: 'Become Driver',
                preffixicon: Icons.directions_car),
            const SizedBox(
              height: 24,
            ),
            const LogoutOption()
          ],
        ),
      ),
    );
  }
}

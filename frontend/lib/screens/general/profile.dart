import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/routes/routes.dart';
import 'package:going_going_frontend/services/provider/user_provider.dart';
import 'package:going_going_frontend/widgets/profile/logout_option.dart';
import 'package:going_going_frontend/widgets/profile/profile_option.dart';
import 'package:going_going_frontend/widgets/common/profile_section.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late SharedPreferences prefs;
  deleteUserData() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

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
                firstname: context.read<UserProvider>().firstname,
                lastname: context.read<UserProvider>().lastname,
                gender: context.read<UserProvider>().gender,
                age: context.read<UserProvider>().age.toString(),
                
            ),
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
            LogoutOption(
              onTap: () {
                deleteUserData();
                Navigator.popAndPushNamed(context, Routes.login);
              },
            )
          ],
        ),
      ),
    );
  }
}

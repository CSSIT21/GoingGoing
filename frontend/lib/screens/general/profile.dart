import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/routes/routes.dart';
import 'package:going_going_frontend/services/provider/user_provider.dart';
import 'package:going_going_frontend/services/rest/profile_api.dart';
import 'package:going_going_frontend/widgets/common/back_appbar.dart';
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
  void initState() {
    super.initState();
    ProfileApi.getUserProfile(context);
    ProfileApi.getDriverProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    final _firstname = context.select((UserProvider user) => user.firstname);
    final _lastname = context.select((UserProvider user) => user.lastname);
    final _gender = context.select((UserProvider user) => user.gender);
    final _age = context.select((UserProvider user) => user.age);
    final _pathProfilePic = context.select((UserProvider user) => user.pathProfilePic);

    return Scaffold(
      appBar: const BackAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
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
              firstname: _firstname,
              lastname: _lastname,
              gender: _gender,
              age: _age.toString(),
              pathProfilePic: _pathProfilePic == "" ? "" : _pathProfilePic,
            ),
            const SizedBox(
              height: 36,
            ),
            const ProfileOption(
              navigatePath: Routes.editProfile,
              optionText: 'Edit Profile',
              preFixIcon: Icons.edit,
            ),
            const SizedBox(
              height: 24,
            ),
            const ProfileOption(
                navigatePath: Routes.becomeDriver,
                optionText: 'Become Driver',
                preFixIcon: Icons.directions_car),
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

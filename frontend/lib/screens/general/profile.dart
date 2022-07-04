import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/routes/routes.dart';
import '../../services/native/local_storage_service.dart';
import '../../services/provider/user_provider.dart';
import '../../services/rest/profile_api.dart';
import '../../widgets/common/back_appbar.dart';
import '../../widgets/profile/logout_option.dart';
import '../../widgets/profile/profile_option.dart';
import '../../widgets/common/profile_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = true;

  Future<void> _deleteUserData() async {
    await LocalStorage.prefs.clear();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    await ProfileApi.getUserProfile(context);
    await ProfileApi.getDriverProfile(context);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final _firstname = context.select((UserProvider user) => user.firstname);
    final _lastname = context.select((UserProvider user) => user.lastname);
    final _gender = context.select((UserProvider user) => user.gender);
    final _age = context.select((UserProvider user) => user.age);
    final _pathProfilePic =
        context.select((UserProvider user) => user.pathProfilePic);

    return Scaffold(
      appBar: const BackAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                    pathProfilePic:
                        _pathProfilePic == "" ? "" : _pathProfilePic,
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  ProfileOption(
                    navigatePath: Routes.editProfile,
                    optionText: 'Edit Profile',
                    preFixIcon: Icons.edit,
                    fetchData: _fetchData,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ProfileOption(
                    navigatePath: Routes.becomeDriver,
                    optionText: 'Become Driver',
                    preFixIcon: Icons.directions_car,
                    fetchData: _fetchData,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  LogoutOption(
                    onTap: () {
                      _deleteUserData();
                      Navigator.popAndPushNamed(context, Routes.login);
                    },
                  )
                ],
              ),
            ),
    );
  }
}

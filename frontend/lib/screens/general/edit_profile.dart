import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:going_going_frontend/config/routes/routes.dart';
import 'package:provider/provider.dart';

import '../../constants/assets_path.dart';
import '../../services/native/image_service.dart';
import '../../services/rest/profile_api.dart';
import '../../services/provider/user_provider.dart';
import '../../widgets/common/date_picker_field.dart';
import '../../widgets/common/dropdown_field.dart';
import '../../widgets/common/label_textfield.dart';
import '../../widgets/profile/edit_profile_pic.dart';
import '../../widgets/common/back_appbar.dart';
import '../../widgets/common/button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formkey = GlobalKey<FormState>();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  late DateTime _birthDate;
  late String _selectedGender;
  File? _imageFile;
  String _pathProfilePic = "";

  final List<String> genders = const ['Male', 'Female'];
  bool isSubmit = false;

  void _getImage() async {
    File? file = await ImageService.getImageFromGallery();
    if (file != null) {
      setState(() {
        _imageFile = file;
      });
      debugPrint(_imageFile.toString());
    }
  }

  void _onPickedDate(DateTime picked) {
    setState(() {
      _birthDate = picked;
    });
  }

  void _onSelectedGender(String gender) {
    setState(() {
      _selectedGender = gender;
    });
  }

  @override
  void initState() {
    super.initState();
    // setState(() {
    _firstnameController.text = context.read<UserProvider>().firstname;
    _lastnameController.text = context.read<UserProvider>().lastname;
    _birthDate = context.read<UserProvider>().birthdate;
    _selectedGender = context.read<UserProvider>().gender;
    _pathProfilePic = context.read<UserProvider>().pathProfilePic;
    // });

    if (_pathProfilePic.isNotEmpty) {
      setState(() {
        _imageFile = File(
            '/data/user/0/com.example.going_going_frontend/cache/$_pathProfilePic');
      });
    }
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }

  Future<void> handleUpdate() async {
    setState(() {
      isSubmit = true;
    });
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      isSubmit = false;
      var updatedImage = _pathProfilePic;
      File file = _imageFile ?? File("");

      if (_imageFile != null) {
        var fileName = _imageFile?.path.split('/').last;
        print(fileName);
        updatedImage =
            (await MultipartFile.fromFile(file.path, filename: fileName))
                .filename!;
        print(updatedImage);
        print("------------updated 1-----------");
      }
      print(updatedImage);
      print("------------updated 2----------");
      String dateTimeString =
          _birthDate.toIso8601String().substring(0, 23) + "Z";

      print("------------updated 3----------");
      ProfileApi.updateUserProfile(
          _firstnameController.text,
          _lastnameController.text,
          _selectedGender,
          dateTimeString,
          updatedImage,
          context);
      debugPrint("------updated3-----");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(title: 'Edit Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 32, right: 32, bottom: 24),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const SizedBox(
                height: 36,
              ),
              _imageFile == null
                  ? EditProfilePic(
                      image: const AssetImage(AssetsConstants.profile),
                      onTaped: _getImage,
                    )
                  : EditProfilePic(
                      image: FileImage(_imageFile!),
                      onTaped: _getImage,
                    ),
              const SizedBox(
                height: 36,
              ),
              LabelTextField(
                hintText: 'Enter your firstname',
                labelText: 'Firstname',
                controller: _firstnameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required*';
                  }
                  return null;
                },
              ),
              LabelTextField(
                hintText: 'Enter your lastname',
                labelText: 'Lastname',
                controller: _lastnameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required*';
                  }
                  return null;
                },
              ),
              DatePickerField(
                labelText: 'Birthdate',
                pickedDate: _birthDate,
                onPickedDate: _onPickedDate,
              ),
              DropdownField(
                hintText: 'Select your gender',
                labelText: 'Gender',
                selectedValue: _selectedGender,
                list: genders,
                onChanged: _onSelectedGender,
              ),
              const SizedBox(
                height: 64,
              ),
              Button(
                text: 'Save',
                onPressed: handleUpdate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

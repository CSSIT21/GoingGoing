import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/assets_path.dart';
import '../../services/native/image_service.dart';
import '../../services/rest/profile_api.dart';
import '../../services/provider/user_provider.dart';
import '../../widgets/common/date_picker_field.dart';
import '../../widgets/common/dropdown_field.dart';
import '../../widgets/common/label_text_field.dart';
import '../../widgets/profile/edit_profile_picture.dart';
import '../../widgets/common/back_appbar.dart';
import '../../widgets/common/button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _genders = const ['Male', 'Female'];
  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;
  late DateTime _birthDate;
  late String _selectedGender;
  String _pathProfilePic = "";
  bool _isLoading = true;
  File? _imageFile;

  Future<void> _getImage() async {
    File? file = await ImageService.getImageFromGallery();
    if (file != null) {
      setState(() {
        _imageFile = file;
      });
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
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }

  Future<void> _handleUpdate() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // * Date
      String dateTimeString =
          _birthDate.toIso8601String().substring(0, 23) + "Z";

      // * File
      File file = _imageFile ?? File("");
      var updatedImage = _pathProfilePic;
      if (_imageFile != null) {
        var fileName = _imageFile?.path.split('/').last;
        updatedImage =
            (await MultipartFile.fromFile(file.path, filename: fileName))
                .filename!;
      }

      // * API
      ProfileApi.updateUserProfile(
          _firstnameController.text,
          _lastnameController.text,
          _selectedGender,
          dateTimeString,
          updatedImage,
          context);
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _firstnameController =
          TextEditingController(text: context.read<UserProvider>().firstname);
      _lastnameController =
          TextEditingController(text: context.read<UserProvider>().lastname);
      _birthDate = context.read<UserProvider>().birthdate;
      _selectedGender = context.read<UserProvider>().gender;
      _pathProfilePic = context.read<UserProvider>().pathProfilePic;
    });

    if (_pathProfilePic.isNotEmpty) {
      setState(() {
        _imageFile = File(
            '/data/user/0/com.example.going_going_frontend/cache/$_pathProfilePic');
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(title: 'Edit Profile'),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.only(left: 32, right: 32, bottom: 24),
              child: Form(
                key: _formKey,
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
                      list: _genders,
                      onChanged: _onSelectedGender,
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    Button(
                      text: 'Save',
                      onPressed: _handleUpdate,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

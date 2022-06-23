import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/assets_path.dart';
import '../../services/native/image_service.dart';
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
  final _editProfilrBtnController = TextEditingController();
  late DateTime _birthDate;
  late String _selectedGender;
  File? _imageFile;

  final List<String> genders = const ['Male', 'Female'];
  bool isSubmit = false;

  void _getImage() async {
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
  void initState() {
    super.initState();
    _firstnameController.text = context.read<UserProvider>().firstname;
    _lastnameController.text = context.read<UserProvider>().lastname;
    _birthDate = context.read<UserProvider>().birthdate;
    _selectedGender = context.read<UserProvider>().gender;
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    // _dateController.dispose();
    super.dispose();
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
                onPressed: () {
                  setState(() {
                    isSubmit = true;
                  });
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    isSubmit = false;
                    //call func
                  }
                  _editProfilrBtnController.clear();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

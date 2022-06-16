import 'dart:io';

import 'package:flutter/material.dart';
import 'package:going_going_frontend/constants/assets_path.dart';
import 'package:going_going_frontend/widgets/common/date_picker_field.dart';
import 'package:going_going_frontend/widgets/common/dropdown_field.dart';
import 'package:going_going_frontend/widgets/common/label_textfield.dart';
import 'package:going_going_frontend/widgets/profile/edit_profile_pic.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/common/back_appbar.dart';
import '../../widgets/common/button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
   File? _imageFile = null;
  final ImagePicker _picker = ImagePicker();
  void getImageFromGallery() async {
    XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const BackAppBar(title: 'Edit Profile'),
      body: Padding(padding: const EdgeInsets.only(left: 32, right: 32),
        child: Column(
          children: [
            const SizedBox(
              height: 36,
            ),
            _imageFile == null ? EditProfilePic(
              image: const AssetImage(AssetsConstants.profile),
              onTaped: () {
                getImageFromGallery();
              },
            ) : EditProfilePic(
              image: FileImage(_imageFile!),
              onTaped: () {
                getImageFromGallery();
              },
            ),
            
            const SizedBox(
              height: 36,
            ),
            const LabelTextField(hintText: 'Enter your firstname', labelText: 'Firstname'),
            const LabelTextField(hintText: 'Enter your lastname', labelText: 'Lastname'),
            const DatePickerField(labelText: 'Date'),
            const DropdownField(hintText: 'Select your gender', labelText: 'Gender'),
            const SizedBox(
              height: 64,
            ),
            Button(text: 'Save', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

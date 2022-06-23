import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageService {
  static Future<File?> getImageFromGallery() async {
    final XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  static Future<List<File>?> getImagesFromGallery() async {
    final List<XFile>? pickedImages = await ImagePicker().pickMultiImage();

    if (pickedImages != null) {
      return pickedImages.map((e) => File(e.path)).toList();
    }
    return null;
  }
}

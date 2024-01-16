// ignore_for_file: avoid_print, unused_local_variable, file_names

import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class PhotoController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {    final picker = ImagePicker();

    selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> uploadImage() async {
    if (selectedImage.value == null) return;

    // Replace 'YOUR_UPLOAD_URL' with the actual URL where you want to upload the image
    final uploadUrl = Uri.parse('YOUR_UPLOAD_URL');

    List<int> imageBytes = selectedImage.value!.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    final response = await http.post(
      uploadUrl,
      body: {
        'image': base64Image,
      },
    );

    // Handle the response as needed
    print(response.body);
  }
}

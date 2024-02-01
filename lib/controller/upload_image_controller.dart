// ignore_for_file: avoid_print, unused_local_variable, file_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:rudra_it_hub/view/widgets/common_snack_bar.dart';

import '../appUrl/all_url.dart';
import '../splash_screen.dart';

class PhotoController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);

  Future<void> pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {final picker = ImagePicker();
    selectedImage.value = File(pickedFile.path);
   if(context.mounted){
     uploadImage(context);
   }
    }
  }

  Future<void> uploadImage(BuildContext context) async {
    if (selectedImage.value == null) return;

    // Replace 'YOUR_UPLOAD_URL' with the actual URL where you want to upload the image
    final uploadUrl = Uri.parse("$baseUrl$uploadUserProfileUrl");

    List<int> imageBytes = selectedImage.value!.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    var headers = <String, String>{};
    // headers['Content-Type'] = 'application/json';
    headers['Authorization'] = userBearerToken ?? '';

    final response = await http.post(
      uploadUrl,
      body: {
        'avatar': base64Image,
      },
      headers: headers
    );
    if(response.statusCode == 200) {
      if(context.mounted)
        {commonSnackBar(context: context, msg: "Profile Upload successfully");}
    }
    else{
if(context.mounted){
  commonSnackBar(context: context, msg: response.body);

}
}
    // Handle the response as needed
    print(response.body);
  }
}
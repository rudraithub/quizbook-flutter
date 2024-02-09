// ignore_for_file: override_on_non_overriding_member

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rudra_it_hub/appUrl/all_url.dart';
import 'package:rudra_it_hub/http_methods/http_all_method.dart';
import 'package:rudra_it_hub/model/chap_of_sub_model.dart';
import 'package:rudra_it_hub/widgets/commo_alert_dilog.dart';
import 'package:rudra_it_hub/widgets/common_snack_bar.dart';

class ChapterController extends GetxController {
  var isLoading = true.obs;
  Rx<Chapter> stdList = Chapter(status: 0, data: [], message: '').obs;

  @override
  void fetchChapter(int stdId, int subId, BuildContext context) async {
    try {
      isLoading(true);

      var headers = <String, String>{};
      headers['Content-Type'] = 'application/json';

      var body = <String, dynamic>{"stdid": stdId, "subid": subId};
      var response =
          await postMethod('$baseUrl$chapterUrl', body, headers, context);

      // var products = await RemoteServices.fatchChapter(stdId, subId);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        stdList.value = chapterFromJson(jsonString);
      } else {
        if (context.mounted) {
          var responseData = json.decode(response.body);
    String message = responseData['message'];
          // CommonAlertDialog(message: message,);
          DialogUtils.showCustomDialog(context,message,
          title: "Gallary",
          okBtnText: "Save",
          cancelBtnText: "Cancel",
          okBtnFunction: () {});
          print('erro');
        }
      }
    } finally {
      isLoading(false);
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rudra_it_hub/http_methods/http_all_method.dart';
import 'package:rudra_it_hub/model/study_model.dart';

import '../appUrl/all_url.dart';

class SubjectProvider extends GetxController {
  var isLoading = true.obs;
  Rx<Temperatures> stdList = Temperatures(data: [], message: '', status: 0).obs;

  @override
  void onInit() {
    BuildContext context = Get.context!;
    fetchStudyModel(context);
    super.onInit();
  }

  void fetchStudyModel(BuildContext context) async {
    try {
      isLoading(true);

      var response = await getMethode('$baseUrl$dashboardUrl' ,context);
      if (response.statusCode == 200) {
        stdList.value = temperaturesFromJson(response.body);
      } else {
        // print('Error to load Data');
      }
    } finally {
      isLoading(false);
    }
  }
}

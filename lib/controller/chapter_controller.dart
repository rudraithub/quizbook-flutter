// ignore_for_file: override_on_non_overriding_member

import 'package:get/get.dart';
import 'package:rudra_it_hub/model/chap_of_sub_model.dart';

import '../services/remote_services.dart';

class ChapterController extends GetxController {
  var isLoading = true.obs;
  Rx<Chapter> stdList = Chapter(status: 0, data: [], message: '').obs;

  @override
  void fetchChapter(int stdId, int subId) async {
    try {
      isLoading(true);
      var products = await RemoteServices.fatchChepter(stdId, subId);

      // print("fetch Chapter fetch Chapter Fetch Chapter ${products.data}");
      if (products.data.isNotEmpty) {
        stdList.value = products;
      } else {
        // stdList.value = stu
      }
    } finally {
      isLoading(false);
    }
  }
}

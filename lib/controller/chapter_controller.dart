import 'package:get/get.dart';
import 'package:rudra_it_hub/model/chap_of_sub_model.dart';

import '../services/remote_services.dart';


class ChapterController extends GetxController{
  var isLoading = true.obs;
  Rx<Chapter> stdList = Chapter(status: 0, data: [], message:'').obs;

  @override

  void fatchChepter(int stdId , int subId) async {
    try {
      isLoading(true);
      var products = await RemoteServices.fatchChepter(stdId, subId);

      print("fatchChepterfatchChepterfatchChepter ${products.data}");
      if (products.data.isNotEmpty) {

        stdList.value = products;
      }
      else{
        // stdList.value = stu
      }
    } finally {
      isLoading(false);
    }
  }
}
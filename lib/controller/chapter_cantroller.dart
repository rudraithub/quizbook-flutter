import 'package:get/get.dart';
import 'package:rudra_it_hub/model/chap_of_sub_model.dart';

import 'package:rudra_it_hub/services/remote_services.dart';

class ChpaterProvider extends GetxController {
  var isLoading = true.obs;
  Rx<Chapter> stdList = Chapter(status: 0, data: [], message: '').obs;

  @override
  void onInit() {
    fatchChepter();
    super.onInit();
  }

  void fatchChepter() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fatchChepter();

      if (products.data.isNotEmpty) {
        stdList.value = products;
        print('cnt Dddd');
      }
      else{
        // stdList.value = stu
      }
    } finally {
      isLoading(false);
    }
  }
}

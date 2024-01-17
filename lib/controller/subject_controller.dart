import 'package:get/get.dart';
import 'package:rudra_it_hub/model/study_model.dart';
import 'package:rudra_it_hub/services/remote_services.dart';
import 'package:rudra_it_hub/StaticData/std_sub.dart';

class SubjectProvider extends GetxController {
  var isLoading = true.obs;
  RxList<StudyModel> stdList = <StudyModel>[].obs;

  @override
  void onInit() {
    fetchStudyModel();
    super.onInit();
  }
  void fetchStudyModel ()async{
    
  try {
    isLoading(true);
    var products = await  RemoteServices.fetchStudyModel();

  if (products.isNotEmpty) {
    stdList.value = products;    
  }
  // else{
  //   stdList.value = stud;
  // }
  } finally{
    isLoading(false);
  }
 
  }
}

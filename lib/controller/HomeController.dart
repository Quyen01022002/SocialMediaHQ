import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/service/API_Post.dart';

import '../model/PostModel.dart';


class HomeController extends GetxController {
  static HomeController instance = Get.find();
  RxList<PostModel> listPost = List<PostModel>.empty(growable: true).obs;
  RxBool isloaded = false.obs;

  void onInit()
  {
    loadPost();
    super.onInit();
  }
  void loadPost() async
  {
    try {
      final prefs = await SharedPreferences.getInstance();

      isloaded(true);
      final userId = prefs.getInt('userId') ?? 0;
      List<PostModel>? result = await API_Post.LoadMainHome(userId);
      if (result != null) {

        listPost.clear();
        listPost.addAll(result);
      }
    }
    finally
    {
      isloaded(false);
    }
  }
}
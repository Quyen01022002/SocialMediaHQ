import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/model/InteractionsEnity.dart';
import 'package:socialmediahq/model/NoticationsModel.dart';
import 'package:socialmediahq/service/API_Notications.dart';
import 'package:socialmediahq/service/API_Post.dart';

import '../model/PostModel.dart';


class NoticationsController extends GetxController {
  RxList<NoticationsModel> listNoticaiotns = List<NoticationsModel>.empty(growable: true).obs;
  RxBool isloaded = false.obs;
  RxBool isliked = false.obs;
  RxInt postid = 0.obs;


  void loadNotications() async
  {
    try {
      final prefs = await SharedPreferences.getInstance();

      isloaded(true);
      final userId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";
      List<NoticationsModel>? result = await API_Notications.LoadNotications(userId,token);
      if (result != null) {

        listNoticaiotns.clear();
        listNoticaiotns.addAll(result);
        update();
      }
    }
    finally
    {
      isloaded(false);
    }
  }

}
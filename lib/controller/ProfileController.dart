import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/model/UsersProfile.dart';
import 'package:socialmediahq/service/API_ProFile.dart';

class ProfileController extends GetxController {
  RxInt follow = 0.obs;
  RxInt following = 0.obs;
  RxInt post = 0.obs;
  RxString fisrt_name = "".obs;
  RxString last_name = "".obs;
  @override
  void onInit()
  {
    loadthongtin();
    super.onInit();
  }


  void loadthongtin() async {
    final prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('userId') ?? 0;
    print("load");


      final userProfile = await API_Profile.profile(userid);
      if(userProfile!=null)
        {
          follow.value=userProfile.countfollow!;
          following.value=userProfile.countfollowing!;
          post.value=userProfile.postquan!;
          fisrt_name.value=userProfile.first_name!;
         last_name.value=userProfile.last_name!;
        }



  }
}

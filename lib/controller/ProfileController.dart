import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/service/API_ProFile.dart';

import '../model/PostModel.dart';
import '../model/UsersEnity.dart';

class ProfileController extends GetxController {
  RxList<PostModel> listPost = List<PostModel>.empty(growable: true).obs;
  RxList<UserEnity> listFriends = List<UserEnity>.empty(growable: true).obs;
  RxInt follow = 0.obs;
  RxInt following = 0.obs;
  RxInt post = 0.obs;
  RxString fisrt_name = "".obs;
  RxString last_name = "".obs;
  RxString Avatar = "".obs;


  void loadthongtin() async {
    final prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('id') ?? 0;
    String token = prefs.getString('token') ?? "";
    print("load");

    try {
      final userProfile = await API_Profile.profile(userid, token);
      if (userProfile != null) {
        listPost.value = userProfile.listpost!;
        listFriends.value = userProfile.friends!;
        follow.value = userProfile.friends!.length!;
        post.value = userProfile.listpost!.length!;
        fisrt_name.value = userProfile.first_name!;
       last_name.value = userProfile.last_name!;
       Avatar.value = userProfile.avatarUrl!;
      }
    } catch (e) {
      print("Error loading profile: $e");
    }
    // Trigger reactive update
    listPost.refresh();
    listFriends.refresh();
  }
  void loadthongtinOther(int id) async {
    final prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('id') ?? 0;
    String token = prefs.getString('token') ?? "";
    print("load");

    try {
      final userProfile = await API_Profile.profile(id, token);
      if (userProfile != null) {
        listPost.value = userProfile.listpost!;
        follow.value = userProfile.friends!.length!;
        post.value = userProfile.listpost!.length!;
        fisrt_name.value = userProfile.first_name!;
        last_name.value = userProfile.last_name!;
        Avatar.value = userProfile.avatarUrl!;
      }
    } catch (e) {
      print("Error loading profile: $e");
    }
    // Trigger reactive update
    listPost.refresh();
  }

}

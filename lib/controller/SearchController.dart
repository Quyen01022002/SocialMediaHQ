import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/UsersEnity.dart';
import '../service/API_Search.dart';


class Search_Controller extends GetxController {
  RxList<UserEnity> listUser = List<UserEnity>.empty(growable: true).obs;
  final textControllerContent = TextEditingController();

  void loadUser() async {
    print("Loading posts...");
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    List<UserEnity>? result = await API_Search.Search(userId, textControllerContent.text,token);
    if (result != null) {
      listUser.clear();
      listUser.addAll(result);
      print("Updated listPost: $listUser");
      update();
    } else {
      listUser.clear();
      update();
    }
    listUser.refresh();
  }


}

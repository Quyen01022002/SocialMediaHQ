import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/model/PostEnity.dart';
import 'package:socialmediahq/model/UsersEnity.dart';
import 'package:socialmediahq/service/API_Post.dart';
import 'package:socialmediahq/service/API_ProFile.dart';

import '../view/dashboard/DashBoard.dart';

class UpdateUserController extends GetxController {
  final textControllerContent = TextEditingController();
  RxString imagePath = ''.obs;
  final contentpost = RxString('');

  void UpdateUser(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    API_Profile.updateAvatar(userId,token,imagePath.value);


  }
}

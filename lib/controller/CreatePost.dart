import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/model/PostEnity.dart';
import 'package:socialmediahq/model/UsersEnity.dart';
import 'package:socialmediahq/service/API_Post.dart';

import '../view/dashboard/DashBoard.dart';

class CreatePostController extends GetxController {
  final textControllerContent = TextEditingController();
  RxString imagePath = ('').obs;
  final contentpost = RxString('');

  void createpost(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;
    PostEntity userEnity = PostEntity(
        user_id: userId,
        content_post: textControllerContent.text,
        timestamp: DateTime.now(),
        status: "");
    final userIsSign = await API_Post.post(userEnity,imagePath.value);

    Future.delayed(Duration(milliseconds: 200), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashBoard()),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/service/API_Post.dart';
class CommentController extends GetxController {
  final textControllerContent = TextEditingController();
  void addcomments(BuildContext context,int postid) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;
    API_Post.Comments(userId, postid, textControllerContent.text);
  }

}
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/model/InteractionsEnity.dart';
import 'package:socialmediahq/service/API_Group.dart';
import 'package:socialmediahq/service/API_Post.dart';

import '../model/PostModel.dart';


class HomeController extends GetxController {
  static HomeController instance = Get.find();
  RxList<PostModel> listPost = List<PostModel>.empty(growable: true).obs;
  RxBool isloaded = false.obs;
  RxBool isliked = false.obs;
  RxInt postid = 0.obs;


  void loadPost() async
  {
    try {
      final prefs = await SharedPreferences.getInstance();
      isloaded(true);
      final userId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";
      List<PostModel>? result = await API_Post.LoadMainHome(userId,token);
      if (result != null) {

        listPost.clear();
        listPost.addAll(result);
        update();
      }
    }
    finally
    {
      isloaded(false);
    }
  }
  void Like() async
  {

    try {
      final prefs = await SharedPreferences.getInstance();

      isliked(true);
      final userId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";
     await API_Post.Liked(token,postid.value,userId);
    }
    finally
    {
      isloaded(false);
    }
  }
  void DeletePost() async
  {

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('id') ?? 0;
      final token = prefs.getString('token') ?? "";
      API_Post.deletePost(postid.value,token);
    }
    finally
    {
      isloaded(false);
    }
  }
  void DeleteReport(int reportid) async
  {

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? "";
      API_Group.deleteReport(reportid,token);
    }
    finally
    {
      isloaded(false);
    }
  }
  void ReportPost() async
  {

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? "";
      API_Group.ReportPost(postid.value,token);
    }
    finally
    {
      isloaded(false);
    }
  }
}
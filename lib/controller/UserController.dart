import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/model/InteractionsEnity.dart';
import 'package:socialmediahq/service/API_Friends.dart';
import 'package:socialmediahq/service/API_Post.dart';

import '../model/PostModel.dart';
import '../model/UsersEnity.dart';


class UserController extends GetxController {
  RxList<UserEnity> list20Usser = List<UserEnity>.empty(growable: true).obs;


  void loadPost() async {
    print("Loading posts...");
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    List<UserEnity>? result = await API_Friend.LoadList20User(token);
    if (result != null) {
      list20Usser.clear();
      list20Usser.addAll(result);
      print("Updated listPost: $list20Usser");
      update();
    } else {
      list20Usser.clear();
      update();
    }
  }

  void addFriends(int? friendID) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    final userId = prefs.getInt('id') ?? 0;
    API_Friend.addFriends(userId,friendID, token);
  }
}

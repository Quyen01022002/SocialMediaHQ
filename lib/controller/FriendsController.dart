import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/model/InteractionsEnity.dart';
import 'package:socialmediahq/service/API_Friends.dart';
import 'package:socialmediahq/service/API_Post.dart';

import '../model/PostModel.dart';
import '../model/UsersEnity.dart';


class FriendController extends GetxController {
  RxList<UserEnity> listPost = List<UserEnity>.empty(growable: true).obs;


  void loadPost() async {
    print("Loading posts...");
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    List<UserEnity>? result = await API_Friend.LoadFriends(userId, token);
    if (result != null) {
      listPost.clear();
      listPost.addAll(result);
      print("Updated listPost: $listPost");
      update();
    } else {
      listPost.clear();
      update();
    }
  }

  void loadFriends() async {
    print("Loading posts...");
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    List<UserEnity>? result = await API_Friend.LoadFriends(userId, token);
    if (result != null) {
      listPost.clear();
      listPost.addAll(result);
      print("Updated listPost: $listPost");
      update();
    } else {
      listPost.clear();
      update();
    }
  }
  void acceptFriends(int? friendID) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    API_Friend.acceptFriends(friendID, token);
  }
  void unFriends(int? friendID) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    final userId = prefs.getInt('id') ?? 0;
    API_Friend.unFriends(userId,friendID, token);
  }
}

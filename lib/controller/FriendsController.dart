import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/model/InteractionsEnity.dart';
import 'package:socialmediahq/model/MessageModel.dart';
import 'package:socialmediahq/service/API_Friends.dart';
import 'package:socialmediahq/service/API_Message.dart';
import 'package:socialmediahq/service/API_Post.dart';

import '../model/UsersEnity.dart';



class FriendController extends GetxController {
  RxList<UserEnity> listPost = List<UserEnity>.empty(growable: true).obs;
  RxList<UserEnity> listFriend = List<UserEnity>.empty(growable: true).obs;


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
    List<UserEnity>? result = await API_Friend.LoadListFriends(userId, token);
    if (result != null) {
      listFriend.clear();
      listFriend.addAll(result);
      print("Updated listPost: $listFriend");
      update();
    } else {
      listFriend.clear();
      update();
    }
  }
  Future<void> acceptFriends(int? friendID) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    final userId = prefs.getInt('id') ?? 0;

    API_Friend.acceptFriends(friendID, token);
    MessageModel message1 = MessageModel(
        id: 0,
        userId: userId,
        friendId: friendID,
        content: "Bây giờ chúng ta đã là bạn bè",
        createdDate: DateTime.now());
    await API_Message.createMessage(token, message1);
  }
  void unFriends(int? friendID) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    final userId = prefs.getInt('id') ?? 0;
    API_Friend.unFriends(friendID, token);
  }
}

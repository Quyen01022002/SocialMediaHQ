import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/model/GroupModel.dart';
import 'package:socialmediahq/model/UsersEnity.dart';
import 'package:socialmediahq/view/Group/AddMembers.dart';
import 'package:socialmediahq/view/Group/HomeGroup.dart';
import 'package:socialmediahq/view/Group/group_screen.dart';

import '../../service/API_Friends.dart';
import '../../service/API_Group.dart';

class HomeGroupController extends GetxController{
  RxString nameGroup = "âclkjcwdnldj".obs;
  RxString descriptionGroup = "".obs;
  final int group_id = 0;
  void GetOneGroup(BuildContext context, int idgroup) async{
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id')??0;
    final token = prefs.getString('token')??"";
    final groupModel = await API_Group.getGroupById(idgroup, token);
    if (groupModel !=  null)
      {
        nameGroup.value = groupModel.name ?? "";
        descriptionGroup.value = groupModel.description ?? "";
      }

    Future.delayed(Duration(milliseconds: 300), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeGroup()),
      );
    });
  }

  void addlistMembers(List<int> listuserid){



  }
  List<UserMember>? users = [];

  Future<void> loadFriends(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    List<UserEnity>? result = await API_Friend.LoadListFriends(userId, "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkb2R1eWhhbzc2NDBAZ21haWwuY29tIiwiaWF0IjoxNzAyMDY4NDc5LCJleHAiOjE3MDIwNjk5MTl9.8C2wPD_dWC8bnq5KrD91f2OV2YRL-6r3T3ve_U5rrcj214w-KPp13s5O3BWyxPGDNInabxhJqWyL-nyGhBLEeQ");
    if (result != null) {
      // Sử dụng vòng lặp forEach để truy cập từng phần tử trong danh sách
      result!.forEach((userEntity) {
        UserMember user = UserMember(id: userEntity.user_id ?? 0,
            firstName: userEntity.first_name ?? "",
            lastName: userEntity.last_name ?? "",
            phone: userEntity.phone ?? "",
            email: userEntity.email ?? "",
            profilePicture: userEntity.avatarUrl ?? "");

        users?.add(user);
      });
    }


    Future.delayed(Duration(milliseconds: 300), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AddMembersGroup()),
      );
    });


  }



}
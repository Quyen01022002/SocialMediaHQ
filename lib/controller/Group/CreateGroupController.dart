import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/model/GroupModel.dart';
import 'package:socialmediahq/view/Group/HomeGroup.dart';
import 'package:socialmediahq/view/Group/group_screen.dart';

import '../../service/API_Group.dart';

class GroupController extends GetxController{
  final textControllerMota = TextEditingController();
  final textControllerNameGroup = TextEditingController();
  final desc = RxString('');
  final nameGroup = RxString('');

  void CreateGroup(BuildContext context) async{
    final description = textControllerMota.text;
    final name_group = textControllerNameGroup.text;
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id')??0;

    GroupModel newGroup = GroupModel(
        name: name_group,
        id: 0,
        createdDate: DateTime.now(),
        description: description,
        updatedDate: DateTime.now(),
        listMembers: []
    );

    final token = prefs.getString('token')??"";
    await API_Group.addGroup(newGroup, token);

    Future.delayed(Duration(milliseconds: 300), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeGroup()),
      );
    });


  }





}
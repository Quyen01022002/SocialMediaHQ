import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/model/UsersEnity.dart';
import 'package:socialmediahq/service/API_dangky.dart';
import 'package:socialmediahq/view/authen/Login_screen.dart';

import '../request/RegisterRequest.dart';
import '../view/authen/InitFollowUser.dart';
import '../view/authen/verify_screen.dart';
import '../view/dashboard/DashBoard.dart';

class SignUpdateController extends GetxController {

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final dateController = TextEditingController();
  final genderController = TextEditingController();


  void signup(BuildContext context) async {
    final firstName=firstNameController.text;
    final lastName=lastNameController.text;
    final Address=addressController.text;
    final date=dateController.text;
    final gender=genderController.text;
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    await API_dangky.UpdateFisrt(token,firstName,lastName,Address,date,gender,userId);

    Future.delayed(Duration(milliseconds: 300), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InitFollowUser()),
      );
    });
  }



}

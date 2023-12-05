import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingController extends GetxController {
  RxString first_name = ('').obs;
  RxString last_name = ('').obs;
  RxString avatar = ('').obs;

  void loadthongtin() async {
    final prefs = await SharedPreferences.getInstance();
    avatar = prefs.getString('avatar') as RxString;
    first_name = prefs.getString('first_name') as RxString;
    last_name = prefs.getString('last_name') as RxString;

  }
}

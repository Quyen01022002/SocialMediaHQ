import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/model/UsersEnity.dart';
import 'package:socialmediahq/service/API_login.dart';

import '../view/dashboard/DashBoard.dart';
class LoginController extends GetxController
{
  final textControllerEmail = TextEditingController();
  final textControllerPass = TextEditingController();
  final pass = RxString('');
  final email = RxString('');
  RxString stateLogin=('').obs;
  void login(BuildContext context) async {
    final email = textControllerEmail.text;
    final password = textControllerPass.text;

    final userEntity = await API_login.Login(email, password);

    if (userEntity != null) {
      await saveLoggedInState(userEntity);
     stateLogin.value ="Đăng nhập thành công";
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => DashBoard()),
        );
      });
    } else {

      stateLogin.value = 'Đăng nhập thất bại';
    }
  }
  Future<void> saveLoggedInState(UserEnity user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    prefs.setInt('userId', user.user_id!);
    prefs.setString("first_name", user.first_name!);
    prefs.setString("last_name", user.last_name!);
    prefs.setString("email", user.email!);
    prefs.setString("avatar", user.avatarUrl!);

  }
  static Future<void> Logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);


  }

}

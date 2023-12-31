import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/model/AuthenticationResponse.dart';
import 'package:socialmediahq/model/UsersEnity.dart';
import 'package:socialmediahq/service/API_login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../view/dashboard/DashBoard.dart';
class LoginController extends GetxController
{
  final textControllerEmail = TextEditingController();
  final textControllerPass = TextEditingController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final pass = RxString('');
  final email = RxString('');
  RxString stateLogin=('').obs;
  void login(BuildContext context) async {
    final email = textControllerEmail.text;
    final password = textControllerPass.text;

    final AuthenticationResponse = await API_login.Login(email, password);

    if (AuthenticationResponse != null) {
      await saveLoggedInState(AuthenticationResponse);
     stateLogin.value ="Đăng nhập thành công";
     String? fcmToken = await _firebaseMessaging.getToken();
      API_login.fcm(AuthenticationResponse.id,AuthenticationResponse.token!,fcmToken!);
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
  Future<void> saveLoggedInState(AuthenticationResponse user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    prefs.setInt('id', user.id!);
    prefs.setString("email", user.email!);
    prefs.setString("firstName", user.firstName!);
    prefs.setString("lastName", user.lastName!);
    prefs.setString("Avatar", user.Avatar!);
    prefs.setString("token", user.token!);

  }
  static Future<void> Logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);


  }

}

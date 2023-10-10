import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/model/UsersEnity.dart';
import 'package:socialmediahq/service/API_dangky.dart';
import 'package:socialmediahq/view/authen/Login_screen.dart';

import '../view/dashboard/DashBoard.dart';

class SignUpController extends GetxController {
  final textControllerFirstname = TextEditingController();
  final textControllerLastname = TextEditingController();
  final textControllerEmail = TextEditingController();
  final textControllerPass = TextEditingController();
  final textControllerRePass = TextEditingController();
  final pass = RxString('');
  final email = RxString('');
  final firstname = RxString('');
  final lastname = RxString('');
  RxString stateLogin = ('').obs;

  void signup(BuildContext context) async {
    UserEnity userEnity = UserEnity(
        first_name: textControllerFirstname.text,
        last_name: textControllerLastname.text,
        email: textControllerEmail.text,
        is_email: true,
        phone: "",
        is_phone: true,
        password_hash: textControllerPass.text,
        hash: "uyến",
        avatarUrl: "",
        is_actived: true,
        created_at: DateTime.now(),
        updated_at: DateTime.now());

    final userIsSign = await API_dangky.dangky(userEnity);
    if (textControllerPass.text != textControllerRePass.text) {
      stateLogin.value = "Mật khẩu không giống";
    }else if(userIsSign==null)
      {
        stateLogin.value = "Email đã tồn tại";
      }
    else {
      stateLogin.value = "Đăng ký thành công";
      Future.delayed(Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Loginscreen(animated: false)),
        );
      });
    }
  }
}

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/controller/LoginController.dart';
import 'package:socialmediahq/model/UserModel.dart';
import 'package:socialmediahq/model/UsersEnity.dart';
import 'package:socialmediahq/service/API_dangky.dart';
import 'package:socialmediahq/service/googleLogin.dart';
import 'package:socialmediahq/view/authen/SignUpdateUser.dart';
import 'package:socialmediahq/view/authen/sign_up_screen.dart';
import 'package:socialmediahq/view/authen/verify_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialmediahq/view/dashboard/DashBoard.dart';

import '../../service/UserProvider.dart';

class Loginscreen extends StatefulWidget {
  final bool animated;

  const Loginscreen({Key? key, required this.animated}) : super(key: key);

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final LoginController myController = Get.put(LoginController());
  GoogleSignInAccount? _currentUser;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  GoogleSignInProvider _googleSignInProvider = GoogleSignInProvider();

  late bool animated;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    animated = widget.animated;
    startAnimation();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
        UserModel userModel = UserModel(
          userName: _currentUser!.displayName ?? '',
          email: _currentUser!.email ?? '',
          avatarUrl: _currentUser!.photoUrl ?? '',
        );

        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userModel);

      });
    });

    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/backgourd.png',
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/login-back.png',
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 280,
            fit: BoxFit.cover,
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            bottom: animated ? 0 : -200,
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 560,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: Column(
                  children: [
                    TextField(
                      controller: myController.textControllerEmail,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFF3F5F7),
                        hintStyle: TextStyle(
                          color: Colors.grey, // Đặt màu cho hint text
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: myController.textControllerPass,
                      obscureText: _isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFF3F5F7),
                        hintStyle: TextStyle(
                          color: Colors.grey, // Đặt màu cho hint text
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          child: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: VerifyScreen(
                              animated: false,
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "FOR GOT PASSWORD",
                        style: TextStyle(
                          // Hiển thị dưới nét gạch chân
                          fontSize: 14,
                          color: Color(0xFF5252C7),
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    Center(
                      child: ElevatedButton(
                        onPressed: ()  {
                          myController.email.value =
                              myController.textControllerEmail.text;
                          myController.pass.value =
                              myController.textControllerPass.text;
                           myController.login(context);

                          Future.delayed(Duration(milliseconds: 500), () {
                            if (myController.stateLogin != null && myController.stateLogin != "") {
                              Flushbar(
                                flushbarPosition: FlushbarPosition.TOP,
                                title: "Đăng nhập",
                                duration: Duration(seconds: 2),
                                icon: myController.stateLogin == "Đăng nhập thất bại"
                                    ? Icon(
                                  Icons.close,
                                  size: 30,
                                  color: Colors.red,
                                )
                                    : Icon(
                                  Icons.check_circle,
                                  size: 30,
                                  color: Colors.green,
                                ),
                                message: myController.stateLogin.toString(),
                              )..show(context);
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          backgroundColor: Color(0xFF8587F1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(100, 18, 125, 18),
                          child: Text('LOGIN',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    Column(
                      children: [
                        Text(
                          "OR LOG IN BY",
                          style:
                          TextStyle(color: Color(0xFF606060), fontSize: 14),
                        ),
                        const SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _googleSignInProvider.handleSignIn(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    'assets/images/google.png',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  'assets/images/facebook.png',
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 36),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: SignUpScreeen(animated: false,state: false,

                                ),
                              ),
                            );
                          },
                          child: RichText(
                            text: const TextSpan(
                              text: "Don't have account?",
                              style: TextStyle(
                                  color: Color(0xFF606060), fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'SIGN UP',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> startAnimation() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      animated = true;
    });
  }


}

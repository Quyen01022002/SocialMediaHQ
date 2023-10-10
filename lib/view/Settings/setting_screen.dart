import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:socialmediahq/controller/LoginController.dart';
import 'package:socialmediahq/service/UserProvider.dart';
import 'package:socialmediahq/service/googleLogin.dart';
import 'package:socialmediahq/view/Settings/ProfileScreen.dart';
import 'package:socialmediahq/view/authen/Login_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    GoogleSignInProvider _googleSignInProvider = GoogleSignInProvider();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Menu",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFF3F5F7),
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.settings),
                      )),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: ProfileScreen(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(26, 0, 26, 0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFF3F5F7),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(26),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            0,
                            0,
                            16,
                            0,
                          ),
                          child: user == null
                              ? ClipOval(
                                  child: Image.asset(
                                  "assets/images/backgourd.png",
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ))
                              : ClipOval(
                                  child: Image.network(
                                  user.avatarUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )),
                        ),
                        user == null
                            ? Text(
                                "Trần Bửu Quyến",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )
                            : Text(
                                user.userName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 6, 0),
                        child: Container(
                          decoration: BoxDecoration(color: Color(0xFFF3F5F7)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(18, 18, 118, 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.add_circle_outline),
                                Text("Đã lưu")
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _googleSignInProvider.handleSignOut(context);
                          LoginController.Logout();
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: Loginscreen(animated: false,),
                            ),

                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 16, 6, 0),
                          child: Container(
                            decoration: BoxDecoration(color: Color(0xFFF3F5F7)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(18, 18, 100, 18),
                              child: Column(
                                children: [
                                  Icon(Icons.add_circle_outline),
                                  Text("Đăng xuất")
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

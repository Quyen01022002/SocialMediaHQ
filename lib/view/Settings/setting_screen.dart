import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/controller/LoginController.dart';
import 'package:socialmediahq/service/UserProvider.dart';
import 'package:socialmediahq/service/googleLogin.dart';
import 'package:socialmediahq/view/Group/group_screen.dart';
import 'package:socialmediahq/view/Page/HomePage.dart';
import 'package:socialmediahq/view/Settings/ProfileScreen.dart';
import 'package:socialmediahq/view/authen/Login_screen.dart';

import '../../controller/SettingController.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingController settingController= Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    // final user = userProvider.user;
    // GoogleSignInProvider _googleSignInProvider = GoogleSignInProvider();
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Color(0xFFF3F5F7)),
          child: Column(
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
                        color: Colors.white,
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
                            child: settingController.avatar.value == null
                                ? ClipOval(
                                    child: Image.asset(
                                    "assets/images/backgourd.png",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ))
                                : ClipOval(
                                    child: Image.asset(
                                      "assets/images/backgourd.png",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  )),
                          ),
                         Text(
                           settingController.first_name.value,
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
                          padding: const EdgeInsets.fromLTRB(8, 16, 6, 0),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(18, 18, 118, 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/images/luu.png",width: 30,height: 40,),
                                  Text("Đã lưu")
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   PageTransition(
                            //     type: PageTransitionType.rightToLeft,
                            //     child: HomePage(),
                            //   ),
                            // );
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
                              decoration: BoxDecoration(color: Colors.white),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(18, 18, 120, 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset("assets/images/trang.png",width: 30,height: 40,),
                                    Text("Trang")
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 6, 0),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(18, 18, 95, 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/images/timkiem.png",width: 30,height: 40,),
                                  Text("Tìm Kiếm")
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: GroupScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 6, 0),
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white),
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(18, 18, 118, 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset("assets/images/nhom.png",width: 30,height: 40,),
                                    Text("Nhóm")
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
      ),
    );
  }
}

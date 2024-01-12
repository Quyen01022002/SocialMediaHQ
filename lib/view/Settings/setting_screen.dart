import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/controller/Group/HomeGroupController.dart';
import 'package:socialmediahq/controller/LoginController.dart';
import 'package:socialmediahq/controller/MessageBoxController.dart';
import 'package:socialmediahq/controller/ProfileController.dart';
import 'package:socialmediahq/service/UserProvider.dart';
import 'package:socialmediahq/service/googleLogin.dart';
import 'package:socialmediahq/view/Group/HomeGroup.dart';
import 'package:socialmediahq/view/Group/group_screen.dart';
import 'package:socialmediahq/view/Message/BoxMess.dart';
import 'package:socialmediahq/view/Message/MessagePage.dart';
import 'package:socialmediahq/view/Page/CreatePage.dart';
import 'package:socialmediahq/view/Page/HomePage.dart';
import 'package:socialmediahq/view/Page/page_screen.dart';
import 'package:socialmediahq/view/Settings/ProfileScreen.dart';
import 'package:socialmediahq/view/authen/Login_screen.dart';

import '../../controller/SettingController.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  ProfileController settingController = Get.put(ProfileController());
  HomeGroupController homeGroupController = Get.put(HomeGroupController());
  MessageBoxController messageBoxController = Get.put(MessageBoxController());
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
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                                10,
                                0,
                              ),
                              child: ClipOval(
                                child: Obx(
                                      () {
                                    final imageUrl = settingController.Avatar.toString();

                                    if (imageUrl.startsWith('http')) {
                                      // Đây là một URL hợp lệ
                                      return Image.network(
                                        imageUrl,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      );
                                    } else {
                                      // Đây có thể là đường dẫn cục bộ
                                      return Image.asset(
                                        "assets/images/backgourd.png",
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      );
                                    }
                                  },
                                ),
                              ),),

                          Obx(
                            () => Text(

                              settingController.fisrt_name.value +
                                  " " +
                                  settingController.last_name.value,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            messageBoxController.loadMessageScreen(context);
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: MessegeScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 16, 6, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(18, 18, 102, 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/images/luu.png",
                                      width: 30,
                                      height: 40,
                                    ),
                                    Text("Tin nhắn")
                                  ],
                                ),
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
                                  child: PageScreen()
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 6, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(18, 18, 120, 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/images/trang.png",
                                      width: 30,
                                      height: 40,
                                    ),
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
                        GestureDetector(
                          onTap: (){

                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 6, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(18, 18, 95, 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/images/timkiem.png",
                                      width: 30,
                                      height: 40,
                                    ),
                                    Text("Tìm Kiếm")
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            homeGroupController.loadHomeGroupScreen(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 6, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(18, 18, 118, 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/images/nhom.png",
                                      width: 30,
                                      height: 40,
                                    ),
                                    Text("Nhóm")
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        LoginController.Logout();
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: Loginscreen(
                              animated: false,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 6, 6, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(18, 18, 90, 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/trang.png",
                                  width: 30,
                                  height: 40,
                                ),
                                Text("Đăng xuất")
                              ],
                            ),
                          ),
                        ),
                      ),
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

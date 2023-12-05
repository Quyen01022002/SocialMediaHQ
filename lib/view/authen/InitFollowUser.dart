import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/controller/UserController.dart';
import 'package:socialmediahq/view/dashboard/DashBoard.dart';

import '../../component/Friends_FollowItem.dart';
import '../../component/Friends_InviteItem.dart';

class InitFollowUser extends StatefulWidget {
  const InitFollowUser({Key? key}) : super(key: key);

  @override
  State<InitFollowUser> createState() => _InitFollowUserState();
}

class _InitFollowUserState extends State<InitFollowUser> {
  final UserController myController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    myController.loadPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Container(
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 150,
                  height: 80,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 26, 16, 0),
              child: Obx(
                    () {
                  print(
                      "Building Obx widget...listFriends Gieo diện:${myController.list20Usser}");
                  return Column(
                    key: ValueKey(myController.list20Usser),
                    // Thêm key vào đây
                    children: myController.list20Usser
                        .map((item) => ItemFollow(
                      friends: item,
                    ))
                        .toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {
            Future.delayed(Duration(milliseconds: 300), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DashBoard()),
              );
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Tiếp Theo",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

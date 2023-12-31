import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/component/Friends_Header.dart';
import 'package:socialmediahq/component/Home_Header.dart';

import '../../component/Friends_InviteItem.dart';
import '../../controller/FriendsController.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({Key? key}) : super(key: key);

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  final FriendController myController = Get.put(FriendController());
  @override
  void initState() {
    super.initState();
    myController.loadPost();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          HomeHeader(),
          FriendHeader(),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFF3F5F7),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      child: RichText(
                        text: TextSpan(
                          text: "Lời mời kết bạn",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' ${myController.listPost.length}',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 26, 16, 0),
                  child: Obx(
                    () {
                      print(
                          "Building Obx widget...listPost Gieo diện:${myController.listPost}");
                      return Column(
                        key: ValueKey(myController.listPost),
                        // Thêm key vào đây
                        children: myController.listPost
                            .map((post) => ItemInvite(
                                  friends: post,
                                ))
                            .toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/controller/FriendsController.dart';
import 'package:socialmediahq/component/Friends_Item.dart';

class FriendList extends StatefulWidget {
  const FriendList({Key? key}) : super(key: key);

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  final FriendController myController = Get.put(FriendController());

  @override
  void initState() {
    super.initState();
    myController.loadFriends();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bạn Bè'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search button tap
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${myController.listFriend.length} Bạn Bè',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF3F5F7),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Obx(
                        () {
                      return ListView.builder(
                        itemCount: myController.listFriend.length,
                        itemBuilder: (context, index) {
                          final friend = myController.listFriend[index];
                          return ItemFriend(friends: friend);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

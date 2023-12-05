import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/model/UsersEnity.dart';

import '../controller/FriendsController.dart';

class ItemFriend extends StatefulWidget {
  final UserEnity friends;
  const ItemFriend({Key? key,required this.friends}) : super(key: key);

  @override
  State<ItemFriend> createState() => _ItemInviteState();
}

class _ItemInviteState extends State<ItemFriend> {
  final FriendController myController = Get.find();

  late bool stateAccept=true;
  late bool stateUnfriends=true;
  @override
  void initState() {
    super.initState();
    stateAccept = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,16,0,16),
      child: Container(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: ClipOval(
                child: Image.asset(
                  "assets/images/backgourd.png",

                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.friends.first_name.toString()+" "+widget.friends.last_name.toString(),
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 6,),
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        "assets/images/backgourd.png",
                        width: 15,
                        height: 15,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(widget.friends.countFriend.toString() + " bạn chung")
                  ],
                ),
                const SizedBox(height: 6,),
              ],
            ),
          ],
        ),
      ),
    );
  }

}


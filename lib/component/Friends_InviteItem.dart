import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/model/UsersEnity.dart';

import '../controller/FriendsController.dart';

class ItemInvite extends StatefulWidget {
  final UserEnity friends;
  const ItemInvite({Key? key,required this.friends}) : super(key: key);

  @override
  State<ItemInvite> createState() => _ItemInviteState();
}

class _ItemInviteState extends State<ItemInvite> {
  final FriendController myController = Get.put(FriendController());

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
                child: Image.network(
                  widget.friends.avatarUrl.toString(),

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
                      child: Image.network(
                        widget.friends.avatarUrl.toString(),
                        width: 15,
                        height: 15,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(widget.friends.countFriend.toString() + " bạn chung")
                  ],
                ),
                const SizedBox(height: 6,),
                stateAccept&&stateUnfriends?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 28.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF8587F1),
                          ),
                          onPressed: () {
                            setState(() {
                              stateAccept=false;
                            });
                             myController.acceptFriends(widget.friends.idFriends);
                          },
                          child: Text("Chấp nhận")),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFD7D4D4),
                        ),
                        onPressed: () {
                          setState(() {
                            stateUnfriends=false;
                          });
                          myController.unFriends(widget.friends.idFriends);
                        },
                        child: Text("Xóa")),
                  ],
                ): stateUnfriends?Text("Các bạn đã là bạn bè"):Text("Đã gỡ lời mời"),
              ],
            ),
          ],
        ),
      ),
    );
  }

}


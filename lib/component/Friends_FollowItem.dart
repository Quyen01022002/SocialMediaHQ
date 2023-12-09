import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialmediahq/controller/UserController.dart';
import 'package:socialmediahq/model/UsersEnity.dart';

import '../controller/FriendsController.dart';
import '../view/Settings/ProfileScreenOther.dart';

class ItemFollow extends StatefulWidget {
  final UserEnity friends;

  const ItemFollow({Key? key, required this.friends}) : super(key: key);

  @override
  State<ItemFollow> createState() => _ItemInviteState();
}

class _ItemInviteState extends State<ItemFollow> {
  late bool stateFriend = true;
  final UserController myController = Get.put(UserController());
  @override
  void initState() {
    super.initState();

        stateFriend=widget.friends.isFriends!;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 5, 26, 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: GestureDetector(
          onTap: ()
          {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: ProfileScreenOther(id: widget.friends.user_id!,),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                      widget.friends.first_name.toString() +
                          widget.friends.last_name.toString(),
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
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
                        Text(" bạn chung")
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 0.0),
                          child: stateFriend==false
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF8587F1),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      stateFriend = true;
                                    });
                                    myController
                                        .addFriends(widget.friends.user_id);
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(45, 10, 45, 10),
                                    child: Text("Thêm Bạn Bè"),
                                  ))
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF97979D),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      stateFriend = true;
                                    });
                                    myController
                                        .unFriends(widget.friends.user_id);
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(45, 10, 45, 10),
                                    child: Text("Hủy"),
                                  )),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

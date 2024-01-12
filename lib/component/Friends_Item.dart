import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialmediahq/model/UsersEnity.dart';

import '../controller/FriendsController.dart';
import '../view/Settings/ProfileScreenOther.dart';
import 'Post/update_post.dart';

class ItemFriend extends StatefulWidget {
  final UserEnity friends;

  const ItemFriend({Key? key, required this.friends}) : super(key: key);

  @override
  State<ItemFriend> createState() => _ItemInviteState();
}

class _ItemInviteState extends State<ItemFriend> {
  final FriendController myController = Get.find();

  late bool stateAccept = true;
  late bool stateUnfriends = true;

  @override
  void initState() {
    super.initState();
    stateAccept = true;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            widget.friends.avatarUrl.toString(),
          ),
        ),
        title: Text(
          '${widget.friends.first_name} ${widget.friends.last_name}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${widget.friends.countFriend} bạn chung',
        ),
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: ProfileScreenOther(id: widget.friends.user_id!,),
            ),
          );
        },
        trailing: IconButton(
          icon: Icon(Icons.more_vert), // Use any icon you prefer
          onPressed: () {
            _showBottomSheet(context, widget.friends,myController);
          },
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context, UserEnity friend,FriendController friendController) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext builderContext) {
      return Container(
        child: Wrap(
          children: <Widget>[
            Card(
              elevation: 3,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    friend.avatarUrl.toString(),
                  ),
                ),
                title: Text(
                  '${friend.first_name} ${friend.last_name}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  '${friend.countFriend} bạn chung',
                ),
                onTap: () {
                  // Handle friend item tap
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text(
                'Hủy kết bạn',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                _showDeleteConfirmationDialog(context,friend,friendController);
              },
            ),
            // Add more items as needed
          ],
        ),
      );
    },
  );
}
void _showDeleteConfirmationDialog(BuildContext context, UserEnity friends,FriendController friendController) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('Xác nhận hủy kết bạn'),
        content: Text('Bạn có chắc chắn muốn hủy kết bạn với '+friends.first_name.toString()+' '+friends.last_name.toString()+' ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Đóng hộp thoại
            },
            child: Text(
              'Hủy',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              friendController.unFriends(friends.idFriends);
              Navigator.of(dialogContext).pop(); // Đóng hộp thoại
            },
            child: Text(
              'Xóa',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}


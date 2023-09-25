import 'package:flutter/material.dart';
import 'package:socialmediahq/component/Friends_Header.dart';
import 'package:socialmediahq/component/Home_Header.dart';


import '../../component/Friends_Invite.dart';

class WatchScreen extends StatefulWidget {
  const WatchScreen({Key? key}) : super(key: key);

  @override
  State<WatchScreen> createState() => _WatchScreenState();
}

class _WatchScreenState extends State<WatchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          HomeHeader(),
          FriendHeader(),
          InviteComponent(),
        ],
      ),
    );
  }
}

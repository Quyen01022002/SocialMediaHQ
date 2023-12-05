import 'package:flutter/material.dart';

import 'notification_item.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Color(0xFFF3F5F7)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 26),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Thông Báo",
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
              Padding(
                padding: const EdgeInsets.only(left: 26.0),
                child: Text(
                  "Mới",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              //NotificationsItem(),
            ],
          ),
        ),
      ),
    );
  }
}

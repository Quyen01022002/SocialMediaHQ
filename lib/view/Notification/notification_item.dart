import 'package:flutter/material.dart';
class NotificationsItem extends StatefulWidget {
  const NotificationsItem({Key? key}) : super(key: key);

  @override
  State<NotificationsItem> createState() => _NotificationsItemState();
}

class _NotificationsItemState extends State<NotificationsItem> {
  final List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index]),
        );
      },
    );
  }
}

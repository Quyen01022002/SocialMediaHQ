import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final bool isRead;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.time,
    this.isRead = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(10),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.blue, // You can customize the color
        child: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isRead ? Colors.black : Colors.blue,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: isRead ? Colors.grey : Colors.black,
        ),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            time,
            style: TextStyle(
              color: isRead ? Colors.grey : Colors.blue,
            ),
          ),
          if (!isRead)
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'New',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      onTap: () {
        // Add your logic for handling tap on the notification item
      },
    );
  }
}

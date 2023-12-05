import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final int maxLines;

  ExpandableTextWidget({required this.text, this.maxLines = 3});

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: expanded ? null : 100,
          overflow: TextOverflow.ellipsis,
        ),
        if (widget.text.length > widget.maxLines * 30)
          GestureDetector(
            onTap: () {

              setState(() {
                expanded = !expanded;
              });
            },
            child: Text(
              expanded ? 'Xem thêm':'Thu gọn',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
      ],
    );
  }
}

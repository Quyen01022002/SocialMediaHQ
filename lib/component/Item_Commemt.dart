import 'package:flutter/material.dart';

class ItemComment extends StatefulWidget {
  const ItemComment({Key? key}) : super(key: key);

  @override
  State<ItemComment> createState() => _ItemCommentState();
}

class _ItemCommentState extends State<ItemComment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,6,16,6),
      child: Container(
        decoration: BoxDecoration(color:Color(0xFFF6F7F9),),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0,0,6,15),
              child: ClipOval(
                  child: Image.asset(
                "assets/images/post1.png",
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Trần Bửu Quyến",
                    style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.none,
                        color: Colors.black)),
                Text("Nội dụng",
                    style: TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.none,
                        color: Colors.black)),
                Text("1 phút",
                    style: TextStyle(
                        fontSize: 10,
                        decoration: TextDecoration.none,
                        color: Colors.grey)),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

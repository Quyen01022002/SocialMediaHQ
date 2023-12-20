import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialmediahq/component/Friends_Item.dart';
import '../view/Friends/friendList.dart';

class FriendHeader extends StatefulWidget {
  const FriendHeader({Key? key}) : super(key: key);

  @override
  _FriendHeaderState createState() => _FriendHeaderState();
}

class _FriendHeaderState extends State<FriendHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF3F5F7),
          border: Border(
            bottom: BorderSide(
              color: Color(0xFF5252C7),
              width: 1.0,
            ),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Bạn bè",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                        width: 60,
                        height: 25,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text("Gợi ý"))),
                  ),
                  GestureDetector(
                    onTap: (){
                      print("Dô");
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: FriendList(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                          width: 60,
                          height: 25,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(child: Text("Bạn bè"))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

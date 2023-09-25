import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialmediahq/component/Home_Header.dart';
import 'package:socialmediahq/component/Home_Post.dart';
import 'package:socialmediahq/view/Home/ViewPostScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF3F5F7),
        ),
        child: Column(
          children: [
            HomeHeader(),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF3F5F7),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 26, 16, 16),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: ViewPostScreen(),
                          ),
                        );
                      },
                      child:Home_Post(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

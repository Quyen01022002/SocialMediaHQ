import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialmediahq/component/Home_Header.dart';
import 'package:socialmediahq/component/Post/Home_Post.dart';
import 'package:socialmediahq/controller/HomeController.dart';
import 'package:socialmediahq/view/Home/ViewPostScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController myController = Get.put(HomeController());
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    myController.loadPost();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }

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
                  child: SizedBox(
                    height: 595.0,
                    child: ListView.builder(
                      itemCount: myController.listPost.length,
                      itemBuilder: (context, index) {
                        final post = myController.listPost[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: ViewPostScreen( postModel: post,),
                              ),
                            );
                          },
                          child: AnimatedOpacity(
                              duration: Duration(milliseconds: 100),
                              opacity: opacity,
                              child: Home_Post(
                                postModel: post,
                              )),
                        );
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

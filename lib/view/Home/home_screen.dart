import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialmediahq/component/Home_Header.dart';
import 'package:socialmediahq/component/Post/Home_Post.dart';
import 'package:socialmediahq/controller/HomeController.dart';
import 'package:socialmediahq/view/Home/ViewPostScreen.dart';

import 'SearchScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final HomeController myController = Get.put(HomeController());
  double opacity = 0.0;
  bool isHeaderVisible = true;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    myController.loadPost();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final isScrollingDown = _scrollController.position.userScrollDirection ==
          ScrollDirection.forward;
      if (isScrollingDown != isHeaderVisible) {
        setState(() {
          isHeaderVisible = isScrollingDown;
        });
      }
    });

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
            isHeaderVisible
                ?  AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: isHeaderVisible ? 1.0 : 0.0,
              child: HomeHeader(),
            ): SizedBox(),
            Expanded(
              child: Obx(
                    () =>
                    NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        return true;
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: myController.listPost.length,
                        itemBuilder: (context, index) {
                          final post = myController.listPost[index];
                          return  AnimatedOpacity(
                              duration: Duration(milliseconds: 100),
                              opacity: opacity,
                              child: Home_Post(postModel: post),
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
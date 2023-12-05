import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialmediahq/controller/HomeController.dart';
import 'package:socialmediahq/model/PostModel.dart';
import 'package:socialmediahq/view/Comments/CommentHome.dart';

import '../../view/Comments/ContentComments.dart';


class Home_Post extends StatefulWidget {
  final PostModel postModel;

  const Home_Post({Key? key, required this.postModel}) : super(key: key);

  @override
  State<Home_Post> createState() => _Home_PostState();
}

class _Home_PostState extends State<Home_Post> {
  late bool statelike=true;

  HomeController home_postcontroller = new HomeController();

  @override
  void initState() {
    super.initState();
    statelike = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          statelike = !statelike;
        });
        home_postcontroller.postid.value = widget.postModel.id;
        home_postcontroller.Like();
        print("Like");
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipOval(
                          child: Image.asset(
                        "assets/images/backgourd.png",
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      )),
                    ),
                    Column(
                      children: [
                        Text(
                          widget.postModel.createBy.firstName,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "1 giờ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFFCECECE),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (){

                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(Icons.more_horiz),
                  ),
                ),
              ],
            ),
            widget.postModel.listAnh.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child:ExpandableTextWidget(
                      text:
                      widget.postModel.contentPost.toString(),
                      maxLines: 3,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: ExpandableTextWidget(
                          text: widget.postModel.contentPost.toString(),
                          maxLines: 3,
                        ),
                      ),
                      Container(
                        height: 500,
                        decoration: BoxDecoration(color: Colors.grey),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.postModel.listAnh.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                widget.postModel.listAnh[index].link_picture,


                                fit: BoxFit.cover, // Để ảnh nằm đúng trong phạm vi của nó
                              ),
                            );
                          },
                        ),
                      )

                    ],
                  ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.turned_in_not_outlined,
                    color: Color(0xFF5252C7),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.bottomToTop,
                              child: CommentHome(
                                postEntity: widget.postModel,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  widget.postModel.comment_count
                                      .toString(),
                                  style: TextStyle(color: Color(0xFF5252C7)),
                                ),
                              ),
                              Icon(
                                Icons.mode_comment_outlined,
                                color: Color(0xFF5252C7),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              statelike?(widget.postModel.like_count).toString():(widget.postModel.like_count-1).toString(),
                              style: TextStyle(color: Color(0xFF5252C7)),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  statelike = !statelike;
                                });
                                home_postcontroller.postid.value =
                                    widget.postModel.id;
                                home_postcontroller.Like();
                                print("Like");
                              },
                              child: widget.postModel.user_liked == false
                                  ? Icon(Icons.favorite_border,
                                      color: Color(0xFF5252C7))
                                  : Icon(Icons.favorite, color: Colors.red)),
                        ],
                      ),
                    ],
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

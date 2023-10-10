import 'package:flutter/material.dart';
import 'package:socialmediahq/model/PostModel.dart';

class Home_Post extends StatefulWidget {
  final PostModel postModel;

  const Home_Post({Key? key, required this.postModel}) : super(key: key);

  @override
  State<Home_Post> createState() => _Home_PostState();
}

class _Home_PostState extends State<Home_Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Text(
                    widget.postModel.post.first_name,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  "1 giờ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFCECECE),
                  ),
                ),
              ),
            ],
          ),
          widget.postModel.listImg.isEmpty
              ? Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(widget.postModel.post.content_post),
              )
              : Center(child: Image.asset("assets/images/post1.png")),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.add_circle_outline,
                  color: Color(0xFF5252C7),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              "21",
                              style: TextStyle(color: Color(0xFF5252C7)),
                            ),
                          ),
                          Icon(
                            Icons.message,
                            color: Color(0xFF5252C7),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            "150",
                            style: TextStyle(color: Color(0xFF5252C7)),
                          ),
                        ),
                        Icon(Icons.favorite_border, color: Color(0xFF5252C7)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

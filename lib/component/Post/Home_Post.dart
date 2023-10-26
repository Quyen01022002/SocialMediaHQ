import 'package:flutter/material.dart';
import 'package:socialmediahq/controller/HomeController.dart';
import 'package:socialmediahq/model/PostModel.dart';

class Home_Post extends StatefulWidget {
  final PostModel postModel;

  const Home_Post({Key? key, required this.postModel}) : super(key: key);

  @override
  State<Home_Post> createState() => _Home_PostState();
}

class _Home_PostState extends State<Home_Post> {
  late bool statelike;

  HomeController home_postcontroller=new HomeController();
   @override
   void initState() {
     super.initState();
     statelike = widget.postModel.post.user_liked;
   }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: (){
        setState(() {
          statelike=!statelike;
        });
        home_postcontroller.postid.value=widget.postModel.post.post_id;
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
                : FutureBuilder(
                    future: loadImages(widget.postModel.listImg[0].link_picture),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Center(child: Image.network(snapshot.data!));
                        }
                      } else {
                        return buildPlaceholder();
                      }
                    },
                  ),
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
                                widget.postModel.post.comment_count.toString(),
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
                              widget.postModel.post.like_count.toString(),
                              style: TextStyle(color: Color(0xFF5252C7)),
                            ),
                          ),
                          GestureDetector(
                            onTap:(){
                              setState(() {
                                statelike=!statelike;
                              });
                              home_postcontroller.postid.value=widget.postModel.post.post_id;
                              home_postcontroller.Like();
                              print("Like");
                            },
                              child:statelike==false?Icon(Icons.favorite_border,
                              color: Color(0xFF5252C7)):Icon(Icons.favorite,
                                  color: Colors.red)),
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

Widget buildPlaceholder() {
  return Container(
    width: double.infinity,
    height: 200,
    color: Colors.grey,
  );
}

Future<String> loadImages(String images) async {
  if (images.isNotEmpty) {
    return images;
  } else {
    return 'Đường dẫn mặc định hoặc ảnh không có';
  }
}

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/model/PostModel.dart';

import '../../controller/CommentController.dart';
import '../../controller/HomeController.dart';
import '../../model/CommentsEnity.dart';
import '../Comments/CommentHome.dart';
import '../Comments/CommentItems.dart';
import '../Comments/ContentComments.dart';
import '../Settings/ProfileScreenOther.dart';

class ViewPostScreen extends StatefulWidget {
  final PostModel postModel;

  const ViewPostScreen({Key? key, required this.postModel}) : super(key: key);

  @override
  State<ViewPostScreen> createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  late bool statecommentsview = false;
  late bool statecontent = false;
  late bool statelike=false;
  late int contlike=0;
  late String formattedTime = '';
  final List<CommentEntity> comments = [];
  HomeController home_postcontroller = new HomeController();
  late int postid = widget.postModel.id;
  final CommentController myController = Get.put(CommentController());

  @override
  void initState() {
    super.initState();
    statelike = widget.postModel.user_liked;
    formattedTime = formatTimeDifference(widget.postModel.timeStamp);
    contlike=widget.postModel.like_count;
    FirebaseDatabase.instance
        .reference()
        .child('posts/$postid/comments')
        .onChildAdded
        .listen((event) {
      final commentData = event.snapshot.value as Map;
      final newComment = CommentEntity(
        content_post: commentData['content'],
        timestamp: commentData['timestamp'],
        user_id: commentData['user_id'],
        avatar: commentData['avatar'],
        first_name: commentData['firstName'],
        last_name: commentData['lastName'],
      );
      setState(() {
        comments.add(newComment);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 500.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Row(
                  children: <Widget>[

                  ],
                ),

                background:  ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.postModel.listAnh.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Image.network(
                        widget.postModel.listAnh[index].link_picture,
                        fit: BoxFit.cover, // Để ảnh nằm đúng trong phạm vi của nó
                        width: MediaQuery.of(context).size.width, // Đảm bảo chiều rộng hình ảnh bằng chiều rộng của màn hình
                        height: 500, // Chiều cao của Container
                      ),
                    );
                  },
                ),

                titlePadding: EdgeInsets.only(left: 20, bottom: 20),

              ),

            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: ProfileScreenOther(id: widget.postModel.createBy.id,),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0,10,8,8),
                              child: ClipOval(
                                  child: Image.network(
                                    widget.postModel.createBy.profilePicture,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.postModel.createBy.firstName+" "+widget.postModel.createBy.lastName,
                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  formattedTime,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFCECECE),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0,16,0,10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        statelike?contlike=contlike-1:contlike=contlike+1;
                                        statelike = !statelike;
                                      });
                                      home_postcontroller.postid.value =
                                          widget.postModel.id;
                                      home_postcontroller.Like();
                                      print("Like");
                                    },
                                    child: statelike == false
                                        ? Icon(Icons.favorite_border,
                                      color:Colors.black,)
                                        : Icon(Icons.favorite, color: Colors.red)),
                              ],
                            ),
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
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.mode_comment_outlined,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Icon(
                            Icons.turned_in_not_outlined,
                            color: Colors.black,
                          ),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(contlike.toString()+" lượt thích",style: TextStyle(fontWeight: FontWeight.w500),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16,0,10,20),
                    child: ExpandableTextWidget(
                      text: widget.postModel.contentPost.toString(),
                      maxLines: 1,
                    ),
                  ),
                ],
              ), // Thêm phần tử vào đầu danh sách
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  final comment = comments[index];

                  return CommentItems(commentEntity: comment);
                },
                childCount: comments.length,
              ),
            ),

            SliverToBoxAdapter(
              child: Column(
                children: [
                  Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: myController.textControllerContent,
                            onChanged: (text) {
                              setState(() {
                                statecontent = text != null && text.isNotEmpty;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Thêm bình luận...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: statecontent
                              ? () async {
                            final String content =
                            myController.textControllerContent.text.toString();
                            addCommentToPost(postid, content);
                            myController.addcomments(context, postid);
                          }
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: statecontent ? Colors.blue : Colors.grey,
                          ),
                          child: Text("Đăng"),
                        ),
                      ],
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

Future<void> addCommentToPost(int postID, String commentText) async {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getInt('userId') ?? 0;
  final avatar = prefs.getString('avatar') ?? "";
  final firstName = prefs.getString('first_name') ?? "";
  final lastName = prefs.getString('last_name') ?? "";
  final reference =
  FirebaseDatabase.instance.reference().child('posts/$postID/comments');
  reference.push().set({
    'content': commentText,
    'timestamp': ServerValue.timestamp,
    'user_id': userId,
    'avatar': avatar,
    "firstName": firstName,
    "lastName": lastName,

  });
}

Future<List<CommentEntity>> getCommentsForPost(int postID) async {
  final reference = FirebaseDatabase.instance.reference().child(
      'posts/$postID/comments');
  final completer = Completer<List<CommentEntity>>();

  reference.onValue.listen((event) {
    final DataSnapshot snapshot = event.snapshot;
    final comments = <CommentEntity>[];

    if (snapshot.value != null && snapshot.value is Map) {
      final commentsMap = Map<String, dynamic>.from(snapshot.value as Map);
      commentsMap.forEach((commentKey, commentData) {
        comments.add(CommentEntity(
          content_post: commentData['content'],
          timestamp: commentData['timestamp'],
          user_id: commentData['user_id'],
          avatar: commentData['avatar'],
          first_name: commentData['firstName'],
          last_name: commentData['lastName'],
        ));
      });
    }


    completer.complete(comments);
  });

  return completer.future;
}
String formatTimeDifference(String timeStamp) {
  DateTime dateTime = DateTime.parse(timeStamp);
  DateTime now = DateTime.now();
  Duration difference = now.difference(dateTime);

  if (difference.inDays > 30) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  } else if (difference.inDays >= 1) {
    return '${difference.inDays} ngày trước';
  } else if (difference.inHours > 0) {
    if (difference.inMinutes > 0) {
      return '${difference.inHours} giờ';
    } else {
      return '${difference.inHours} giờ trước';
    }
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} phút trước';
  } else {
    return "Bây giờ";
  }
}

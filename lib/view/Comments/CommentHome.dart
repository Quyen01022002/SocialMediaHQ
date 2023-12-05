import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/controller/CommentController.dart';
import 'package:socialmediahq/model/CommentsEnity.dart';
import 'package:socialmediahq/model/PostEnity.dart';
import 'package:socialmediahq/model/PostModel.dart';
import 'package:socialmediahq/view/Comments/CommentItems.dart';
import 'package:socialmediahq/view/Comments/ContentComments.dart';

class CommentHome extends StatefulWidget {
  final PostModel postEntity;
  const CommentHome({Key? key,required this.postEntity}) : super(key: key);

  @override
  State<CommentHome> createState() => _CommentHomeState();
}

class _CommentHomeState extends State<CommentHome> {
  late bool statecontent = false;
  final List<CommentEntity> comments = [];
  late int postid=widget.postEntity.id;
  final CommentController myController = Get.put(CommentController());

  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance
        .reference()
        .child('posts/$postid/comments')
        .onChildAdded
        .listen((event) {

      final commentData = event.snapshot.value as Map;
      final newComment = CommentEntity(
        content_post: commentData['content'],
        timestamp: commentData['timestamp'],
        user_id:commentData['user_id'],
        avatar:commentData['avatar'],
        first_name:commentData['firstName'],
        last_name:commentData['lastName'],
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
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {

                },
                child: Container(
                  height: 70,
                  child: Center(
                    child: Text(
                      "Bình Luận",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount:  comments.length,
                  itemBuilder: (BuildContext context, int index) {
                    final comment = comments[index];

                    return CommentItems(commentEntity: comment,);

                      ListTile(
                      title: Text(comment.content_post!),
                      subtitle: Text("Timestamp: ${comment.timestamp}"),

                    );
                  },
                )
              ),
              Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: myController.textControllerContent,
                        onChanged: (text) {
                          if (text == null || text.isEmpty) {
                            setState(() {
                              statecontent = false;
                            });
                          } else {
                            setState(() {
                              statecontent = true;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Thêm bình luận...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    statecontent == true
                        ? ElevatedButton(
                        onPressed: () async {
                          final String content=myController.textControllerContent.text.toString();
                          addCommentToPost(postid,content);
                          myController.addcomments(context,postid);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child: Text("Đăng"))
                        : ElevatedButton(
                        onPressed: () async {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                        ),
                        child: Text("Đăng")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> addCommentToPost(int postID, String commentText) async {
  final prefs = await SharedPreferences.getInstance();
final userId = prefs.getInt('userId') ?? 0;
final avatar=prefs.getString('avatar')??"";
final firstName=prefs.getString('first_name')??"";
final lastName=prefs.getString('last_name')??"";
  final reference =
      FirebaseDatabase.instance.reference().child('posts/$postID/comments');
  reference.push().set({
    'content': commentText,
    'timestamp': ServerValue.timestamp,
    'user_id':userId,
    'avatar':avatar,
    "firstName":firstName,
    "lastName":lastName,

  });
}

Future<List<CommentEntity>> getCommentsForPost(int postID) async {
  final reference = FirebaseDatabase.instance.reference().child('posts/$postID/comments');
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
          user_id:commentData['user_id'],
          avatar:commentData['avatar'],
          first_name:commentData['firstName'],
          last_name:commentData['lastName'],
        ));
      });
    }


    completer.complete(comments);


  });

  return completer.future;
}
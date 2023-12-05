import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/model/PostModel.dart';

import '../../controller/CommentController.dart';
import '../../model/CommentsEnity.dart';
import '../Comments/CommentItems.dart';

class ViewPostScreen extends StatefulWidget {
  final PostModel postModel;

  const ViewPostScreen({Key? key, required this.postModel}) : super(key: key);

  @override
  State<ViewPostScreen> createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  late bool statecommentsview = false;
  late bool statecontent = false;
  final List<CommentEntity> comments = [];
  late int postid = widget.postModel.id;
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
                    SizedBox(width: 26),

                    Text('Bình Luận',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,),
                  ],
                ),

                background: Image.network(
                  widget.postModel.listAnh[0].link_picture,
                  fit: BoxFit.cover,
                ),

                titlePadding: EdgeInsets.only(left: 20, bottom: 20),

              ),

            ),
            SliverToBoxAdapter(
              child: Text("Nội dung bài viết"), // Thêm phần tử vào đầu danh sách
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

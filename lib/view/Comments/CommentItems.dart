import 'package:flutter/material.dart';
import 'package:socialmediahq/view/Comments/ContentComments.dart';

import '../../model/CommentsEnity.dart';

class CommentItems extends StatefulWidget {

  final CommentEntity commentEntity;
  const CommentItems({Key? key,required this.commentEntity}) : super(key: key);

  @override
  State<CommentItems> createState() => _CommentItemsState();
}

class _CommentItemsState extends State<CommentItems> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0,8,0,8),
          child: ClipOval(
            child: Image.asset(
              "assets/images/backgourd.png",
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.commentEntity.first_name.toString(),
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16,0,8,0),
                    child: Text(
                      "10 giờ",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top:2.0),
                child: Container(
                  width: 250,
                  child: ExpandableTextWidget(
                    text:
                    widget.commentEntity.content_post.toString(),
                    maxLines: 3,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,8,0,0),
                child: GestureDetector(
                  onTap: (){},
                  child: Row(
                    children: [
                      Text("Trả lời",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                      const SizedBox(width: 15,),
                      Text("Thích",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(26,26.0,0,0),
          child: Icon(Icons.favorite_border),
        ),
      ],
    );
  }
}

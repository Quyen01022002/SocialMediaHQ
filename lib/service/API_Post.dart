import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:socialmediahq/model/InteractionsEnity.dart';
import 'package:socialmediahq/model/PostEnity.dart';
import 'package:socialmediahq/model/PostModel.dart';

import 'package:socialmediahq/service/const.dart';
class API_Post
{

  static Future<List<PostModel>?> LoadMainHome(int userid) async {
    final response = await http.get(
      Uri.parse('$baseUrl/listpost?userid=$userid'),
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        List<PostModel> listPost = postModelListFromJson(responseData);
        return listPost;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  static Future<PostEntity?> post(PostEntity post,String img) async {
    final url = Uri.parse('$baseUrl/post');
    final headers = {"Content-Type": "application/json"};
    final Map<String, dynamic> data = {
        "user_id": post.user_id,
        "content_post": post.content_post,
        "timestamp": post.timestamp?.toIso8601String(),
        "status": post.status
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    final responseData = response.body;
    final postsaved = PostEntity.fromJson(json.decode(responseData));
    if(postsaved==null)
      {

      }
    final url2 = Uri.parse('$baseUrl/postimages');
    final headers2  = {"Content-Type": "application/json"};
    final Map<String, dynamic> dataimg = {
        "link_picture": img,
        "post_id": postsaved.post_id
    };

    final response2 = await http.post(
      url2,
      headers: headers2,
      body: jsonEncode(dataimg),
    );
    final responseDataimg = response.body;
    if(responseDataimg.isEmpty)
      {
        print("Đăng thất bại");
      }
    else
      {
        print("Đăng thành công");

      }
  }
  static Future<InteractionsEntity?> Liked(int userid,int postid) async {
    final url = Uri.parse('$baseUrl/like');
    final headers = {"Content-Type": "application/json"};
    final Map<String, dynamic> data = {
      "user_id": userid,
      "post_id": postid,
      "liked": true,
      "timestamp": DateTime.now().toIso8601String()
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        InteractionsEntity listPost = InteractionsEntity.fromJson(json.decode(responseData));
        return listPost;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
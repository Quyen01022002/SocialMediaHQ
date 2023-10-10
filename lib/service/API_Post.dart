import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
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
      'post': {
        "user_id": post.user_id,
        "content_post": post.content_post,
        "timestamp": post.timestamp?.toIso8601String(),
        "status": post.status
      },
      'picture_Of_Post': {
        "post_id": post.post_id,
        "link_picture": img,

      }
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    final responseData = response.body;

    if (response.statusCode == 200) {
      final postEnity = PostEntity.fromJson(json.decode(responseData));
      print('Đăng bài viết thành công');
      return postEnity;
    }
    else {
      print('Đăng bài viết thất bại: ${response.statusCode}');
      return null;
    }
  }

}
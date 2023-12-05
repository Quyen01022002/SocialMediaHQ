import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:socialmediahq/model/ApiReponse.dart';
import 'package:socialmediahq/model/CommentsEnity.dart';
import 'package:socialmediahq/model/InteractionsEnity.dart';
import 'package:socialmediahq/model/PostEnity.dart';
import 'package:socialmediahq/model/PostModel.dart';

import 'package:socialmediahq/service/const.dart';

class API_Post {
  static Future<List<PostModel>?> LoadMainHome(int userid, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/post/$userid'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        ApiReponse<List<PostModel>> listPost = ApiReponse<List<PostModel>>.fromJson(
          responseData,
              (dynamic json) => List<PostModel>.from(json.map((x) => PostModel.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<PostEntity?> post(
      PostEntity post, List<String> img, String token) async {
    final url = Uri.parse('$baseUrl/post/post');

    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    List<Map<String, String>> listAnh =
        img.map((imageUrl) => {'linkPicture': imageUrl}).toList();

    final Map<String, dynamic> data = {
      "contentPost": post.content_post,
      "listAnh": listAnh,
    };

    await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

  }

  static Future<InteractionsEntity?> Liked(int userid, int postid) async {
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
        InteractionsEntity listPost =
            InteractionsEntity.fromJson(json.decode(responseData));
        return listPost;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<CommentEntity?> Comments(
      int userid, int postid, String content) async {
    final url = Uri.parse('$baseUrl/comments');
    final headers = {"Content-Type": "application/json"};
    final Map<String, dynamic> data = {
      "user_id": userid,
      "post_id": postid,
      "content_post": content,
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
        CommentEntity listPost =
            CommentEntity.fromJson(json.decode(responseData));
        return listPost;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}

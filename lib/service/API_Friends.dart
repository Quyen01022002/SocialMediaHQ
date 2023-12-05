import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:socialmediahq/model/ApiReponse.dart';
import 'package:socialmediahq/model/CommentsEnity.dart';
import 'package:socialmediahq/model/InteractionsEnity.dart';
import 'package:socialmediahq/model/PostEnity.dart';
import 'package:socialmediahq/model/PostModel.dart';
import 'package:socialmediahq/model/UsersEnity.dart';

import 'package:socialmediahq/service/const.dart';

class API_Friend {
  static Future<List<UserEnity>?> LoadFriends(int userid, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/friends/invate/$userid'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        ApiReponse<List<UserEnity>> listPost = ApiReponse<List<UserEnity>>.fromJson(
          responseData,
              (dynamic json) => List<UserEnity>.from(json.map((x) => UserEnity.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  static Future<List<UserEnity>?> LoadListFriends(int userid, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/friends/$userid'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        ApiReponse<List<UserEnity>> listPost = ApiReponse<List<UserEnity>>.fromJson(
          responseData,
              (dynamic json) => List<UserEnity>.from(json.map((x) => UserEnity.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  static Future<List<UserEnity>?> LoadList20User(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/list20follow'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        ApiReponse<List<UserEnity>> listPost = ApiReponse<List<UserEnity>>.fromJson(
          responseData,
              (dynamic json) => List<UserEnity>.from(json.map((x) => UserEnity.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  static void acceptFriends(int? userid, String token) async {
    await http.post(
      Uri.parse('$baseUrl/friends/accept/$userid'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );


  }
  static void addFriends(int? userid,int? friendid, String token) async {
    await http.post(
      Uri.parse('$baseUrl/friends/addfriend?userId=$userid&friendsId=$friendid'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );


  }
  static void unFriends(int? userid, String token) async {
    await http.delete(
      Uri.parse('$baseUrl/friends/unfriend/$userid'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );


  }


}

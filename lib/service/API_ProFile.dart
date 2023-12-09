import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:socialmediahq/service/const.dart';

import '../model/ApiReponse.dart';
import '../model/UserProfile.dart';
class API_Profile
{

  static Future<UserProfile?> profile(int userid, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/$userid'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        ApiReponse<UserProfile> userProfileResponse = ApiReponse<UserProfile>.fromJson(
          responseData,
              (dynamic json) => UserProfile.fromJson(json),
        );
        return userProfileResponse.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static void updateAvatar(int? userid,String token,String Avatar) async {
    final url = Uri.parse('$baseUrl/user/$userid');

    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',};

// Tạo một Map chứa dữ liệu người dùng
    final data = {
      "avatar":Avatar,

    };

    await http.patch(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

  }


}
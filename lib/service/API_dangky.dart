import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:socialmediahq/model/UsersEnity.dart';
import 'package:socialmediahq/service/const.dart';
class API_dangky
{
  static Future<UserEnity?> dangky(UserEnity userEnity) async {
    final url = Uri.parse('$baseUrl/dangky');
    final headers = {"Content-Type": "application/json"};

// Tạo một Map chứa dữ liệu người dùng
    final data = {
      "first_name": userEnity.first_name,
      "last_name": userEnity.last_name,
      "email": userEnity.email,
      "is_email": userEnity.is_email,
      "phone": userEnity.phone,
      "is_phone": userEnity.is_phone,
      "password_hash": userEnity.password_hash,
      "hash": userEnity.hash,
      "profile_picture": userEnity.avatarUrl,
      "is_actived": userEnity.is_actived,
      "create_at": userEnity.created_at?.toIso8601String(),
      "update_at":userEnity.updated_at?.toIso8601String()
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    final responseData = response.body;

    if (response.statusCode == 200) {
      final userEntity = UserEnity.fromJson(json.decode(responseData));
      print('Đăng ký thành công');
      return userEntity;
    }
    else if(response.statusCode == 400)
      {
        print('Email trùng');
        return null;
      }
    else {
      print('Đăng ký thất bại: ${response.statusCode}');
      return null;
    }
  }
  }
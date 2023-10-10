import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:socialmediahq/model/UsersEnity.dart';
import 'package:socialmediahq/service/const.dart';
class API_login
{

  static Future<UserEnity?> Login(String email, String password) async {
    final response = await http.get(
      Uri.parse('$baseUrl/login?email=$email&password_hash=$password'),
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        final userEntity = UserEnity.fromJson(json.decode(responseData));
        return userEntity;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }


}
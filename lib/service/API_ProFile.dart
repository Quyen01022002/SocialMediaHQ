import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:socialmediahq/model/UsersEnity.dart';
import 'package:socialmediahq/model/UsersProfile.dart';
import 'package:socialmediahq/service/const.dart';
class API_Profile
{

  static Future<UserProfile?> profile(int user_id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/profile?user_id=$user_id'),
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        final user = UserProfile.fromJson(json.decode(responseData));
        return user;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }


}
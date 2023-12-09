import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:socialmediahq/model/ApiReponse.dart';
import 'package:socialmediahq/model/CommentsEnity.dart';
import 'package:socialmediahq/model/InteractionsEnity.dart';
import 'package:socialmediahq/model/NoticationsModel.dart';
import 'package:socialmediahq/model/PostEnity.dart';
import 'package:socialmediahq/model/PostModel.dart';

import 'package:socialmediahq/service/const.dart';

class API_Notications {
  static Future<List<NoticationsModel>?> LoadNotications(int userid, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/notifications/$userid'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        ApiReponse<List<NoticationsModel>> listPost =
            ApiReponse<List<NoticationsModel>>.fromJson(
          responseData,
          (dynamic json) =>
              List<NoticationsModel>.from(json.map((x) => NoticationsModel.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }


}

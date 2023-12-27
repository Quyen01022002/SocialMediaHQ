

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:socialmediahq/model/ApiReponse.dart';
import '../model/PageModel.dart';
import 'const.dart';

class API_Page{

  static Future<PageModel?> addPage(PageModel pageModel, String token) async{
    final url = Uri.parse('$baseUrl/page/');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> data = {
      "name": pageModel.name,
      "description": pageModel.description,
      "id": pageModel.id,
      "createdAt": DateFormat('yyyy-MM-dd').format(pageModel.createDate!),
      "updatedAt": DateFormat('yyyy-MM-dd').format(pageModel.updateDate!)
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200){
      final responseDate = response.body;
      if (responseDate.isNotEmpty){
        ApiReponse<PageModel> page = ApiReponse<PageModel>.fromJson(responseDate, (dynamic json) => PageModel.fromJson(json),);
        return page.payload;
      }
      return null;
    }
    return null;
  }
  static Future<PageModel?> getPageById(int pageId, String token) async{
    final url = Uri.parse('$baseUrl/page/$pageId'); // Endpoint to fetch a specific group by ID
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200){
      final responseDate = response.body;
      if (responseDate.isNotEmpty){
        ApiReponse<PageModel> page = ApiReponse<PageModel>.fromJson(responseDate, (dynamic json) => PageModel.fromJson(json),);
        return page.payload;
      }
      return null;
    }
    return null;

  }
  static Future<PageModel?> updatePage(PageModel pageModel, String token) async{
    final url = Uri.parse('$baseUrl/page/update/${pageModel.id}'); // Endpoint to fetch a specific group by ID
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> data = {
      "id": pageModel.id,
      "name": pageModel.name,
      "description": pageModel.description,
      "createdAt": DateFormat('yyyy-MM-dd').format(pageModel.createDate!),
      "updatedAt": DateFormat('yyyy-MM-dd').format(pageModel.updateDate!)
    };
    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
  }

  static Future<PageModel?> deletePageById(PageModel pageModel, String token) async{
    final url = Uri.parse('$baseUrl/page/'); // Endpoint to fetch a specific group by ID
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> data = {
      "id": pageModel.id,
      "name": pageModel.name,
      "description": pageModel.description,
      "createdAt": DateFormat('yyyy-MM-dd').format(pageModel.createDate!),
      "updatedAt": DateFormat('yyyy-MM-dd').format(pageModel.updateDate!)
    };
    final response = await http.delete(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
  }
  static Future<List<PageModel>?> getAllPageList(String token) async {
    final url = Uri.parse('$baseUrl/page/');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final responseData = response.body;
      if (responseData.isNotEmpty) {
        ApiReponse<List<PageModel>> listpage = ApiReponse<
            List<PageModel>>.fromJson(
          responseData, (dynamic json) => List<PageModel>.from(
            json.map((x) => PageModel.fromJson(x))),
        );
        return listpage.payload;
      }
        return null;
    }
    return null;
  }
  static Future<List<PageModel>?> getFollowPageList(String token, int id) async {
    final url = Uri.parse('$baseUrl/page/follow/$id');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final responseData = response.body;
      if (responseData.isNotEmpty) {
        ApiReponse<List<PageModel>> listpage = ApiReponse<
            List<PageModel>>.fromJson(
          responseData, (dynamic json) => List<PageModel>.from(
            json.map((x) => PageModel.fromJson(x))),
        );
        return listpage.payload;
      }
      return null;
    }
    return null;
  }
  static Future<List<PageModel>?> getLikedPageList(String token, int id) async {
    final url = Uri.parse('$baseUrl/page/admin/$id');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final responseData = response.body;
      if (responseData.isNotEmpty) {
        ApiReponse<List<PageModel>> listpage = ApiReponse<
            List<PageModel>>.fromJson(
          responseData, (dynamic json) => List<PageModel>.from(
            json.map((x) => PageModel.fromJson(x))),
        );
        return listpage.payload;
      }
      return null;
    }
    return null;
  }


  static Future<void> followPage(int idUser, int idPage, String token)async {
    final url = Uri.parse('$baseUrl/page/addMembers?userId=$idUser&pageId=$idPage');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    await http.post(
      url,
      headers: headers,
    );
  }
  static Future<void> unfollowPage(int idUser, int idPage, String token)async {
    final url = Uri.parse('$baseUrl/page/unfollow?userId=$idUser&pageId=$idPage');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    await http.delete(
      url,
      headers: headers,
    );
  }

  static Future<bool> checkFollow(int idUser, int idPage, String token) async{
    final url = Uri.parse('$baseUrl/page/getFollowBool?pageId=$idPage&userId=$idUser');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final responseData = response.body;
      if (responseData.isNotEmpty)
        return true;
      return false;
    }
    return false;
  }
  static Future<int> getCountFollow(int idPage, String token) async {
    final url = Uri.parse('$baseUrl/page/$idPage/follow');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      final responseData = response.body;
      if (responseData.isNotEmpty) {
        if (response.statusCode == 200) {
          final responseData = response.body;
          if (responseData.isNotEmpty) {
            ApiReponse<int> count = ApiReponse<int>.fromJson (
              responseData, (dynamic json) => (json),);
            return count.payload;
          }
          return 0;
        }
        return 0;
      }
    }
    return 0;
  }

  static Future<void> updateAdmin(int pageid, int iduser, String token) async{
    final url = Uri.parse('$baseUrl/page/updateAdmin/$pageid');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> data = {
      "adminId": iduser,
      "pageId": pageid
    };
    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
  }
  static Future<String> updateAvatar(int? userid,String token,String Avatar) async {
    final url = Uri.parse('$baseUrl/page/$userid');

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
    return "Success";
  }
  static Future<String> updateBack(int? userid,String token,String Avatar) async {
    final url = Uri.parse('$baseUrl/page/back/$userid');

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
    return "Success";
  }
}
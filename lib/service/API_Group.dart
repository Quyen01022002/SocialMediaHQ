

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:socialmediahq/model/ApiReponse.dart';
import 'package:socialmediahq/model/GroupModel.dart';
import 'package:socialmediahq/model/RepportModel.dart';
import 'package:socialmediahq/model/UsersEnity.dart';
import 'package:socialmediahq/service/API_ProFile.dart';
import 'package:socialmediahq/service/const.dart';
import 'package:socialmediahq/view/Group/group_screen.dart';

import '../model/GroupMemberRequest.dart';

class API_Group{

  static Future<GroupModel?> addGroup(GroupModel newModel, String token) async{
    final url = Uri.parse('$baseUrl/group/');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> data = {
      "name": newModel.name,
      "description": newModel.description
    };
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty){
        ApiReponse<GroupModel> group = ApiReponse<GroupModel>.fromJson(
          responseData,
              (dynamic json) => GroupModel.fromJson(json),
        );
        return group.payload;
      }
      else
        return null;
    } else {
      // Handle error scenarios here
      return null;
    }


  }
  static Future<GroupModel?> updateGroupById(int group_id, GroupModel newModel, String token) async{
    final url = Uri.parse('$baseUrl/group/update/$group_id');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> data = {
      "name": newModel.name,
      "description": newModel.description
    };
    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty){
        ApiReponse<GroupModel> group = ApiReponse<GroupModel>.fromJson(
          responseData,
              (dynamic json) => GroupModel.fromJson(json),
        );
        return group.payload;
      }
      else
        return null;
    } else {
      // Handle error scenarios here
      return null;
    }


  }
  static Future<GroupModel?> addMembersToGroup(String token, List<GroupMemberRequest> members) async{
    final url = Uri.parse('$baseUrl/group/addMembers');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    List<Map<String, dynamic>> data = members.map((member) {
      return {
        "userId": member.user_id,
        "groupId": member.group_id
      };
    }).toList();
    await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
  }
  static Future<GroupModel?> getGroupById(int groupId, String token) async {
    final url = Uri.parse('$baseUrl/group/$groupId'); // Endpoint to fetch a specific group by ID
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

      if (responseData.isNotEmpty){
        ApiReponse<GroupModel> group = ApiReponse<GroupModel>.fromJson(
          responseData,
              (dynamic json) => GroupModel.fromJson(json),
        );
        return group.payload;
      }
      else
        return null;
    } else {
      // Handle error scenarios here
      return null;
    }
  }

  static Future<List<GroupModel>?> getAllGroupsOfAdmin(String token, int adminId) async {
    final url = Uri.parse('$baseUrl/group/admin/$adminId');
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
      if (responseData.isNotEmpty){
        ApiReponse<List<GroupModel>> listgroup = ApiReponse<List<GroupModel>>.fromJson(responseData, (dynamic json) => List<GroupModel>.from(json.map((x) => GroupModel.fromJson(x))),
        );
        return listgroup.payload;
      }
      else
        {
          return null;
        }
    } else {
      // Handle error scenarios here
      return null;
    }
  }
  static Future<List<GroupModel>?> getAllGroupsJoin(String token, int adminId) async {
    final url = Uri.parse('$baseUrl/group/follow/$adminId');
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
      if (responseData.isNotEmpty){
        ApiReponse<List<GroupModel>> listgroup = ApiReponse<List<GroupModel>>.fromJson(responseData, (dynamic json) => List<GroupModel>.from(json.map((x) => GroupModel.fromJson(x))),
        );
        return listgroup.payload;
      }
      else
      {
        return null;
      }
    } else {
      // Handle error scenarios here
      return null;
    }
  }

  static Future<void> deleteGroupById(int groupId, String token) async{
    final url = Uri.parse('$baseUrl/group/$groupId');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

    await http.delete(
      url,
      headers: headers,
    );


  }
  static Future<void> deleteMemberOutGroupById(GroupMemberRequest groupMemberRequest, String token) async {
    int? iduser= groupMemberRequest.user_id;
    int? idgroup = groupMemberRequest.group_id;
    final url = Uri.parse('$baseUrl/group/members/?groupID=$idgroup&userID=$iduser');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> data = {
      "user_id": groupMemberRequest.user_id,
      "group_id": groupMemberRequest.group_id
    };
    await http.delete(
      url,
      headers: headers,
    );


  }
  static Future<String> updateAvatar(int? userid,String token,String Avatar) async {
    final url = Uri.parse('$baseUrl/group/$userid');

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
  static Future<List<UserEnity>?> LoadListFriendsToAdd(int groupid, int userid, String token) async {

    final response = await http.get(
      Uri.parse('$baseUrl/group/isfriend?groupId=$groupid&userId=$userid'),
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

  static Future<void> updateAdmin(int pageid, int iduser, String token) async{
    final url = Uri.parse('$baseUrl/group/updateAdmin/$pageid');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };
    final Map<String, dynamic> data = {
      "adminId": iduser,
      "groupId": pageid
    };
    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
  }
  static Future<List<ReportModel>?> LoadListReport(int groupid, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/report/$groupid'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseData = response.body;

      if (responseData.isNotEmpty) {
        String utf8Data = utf8.decode(responseData.runes.toList());
        ApiReponse<List<ReportModel>> listPost =
        ApiReponse<List<ReportModel>>.fromJson(
          utf8Data,
              (dynamic json) =>
          List<ReportModel>.from(json.map((x) => ReportModel.fromJson(x))),
        );
        return listPost.payload;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
  static void ReportPost(int? postId, String token) async {
    await http.post(
      Uri.parse('$baseUrl/report/post/$postId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );


  }
  static void deleteReport(int? idreport, String token) async {
    await http.delete(
      Uri.parse('$baseUrl/report/$idreport'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );


  }
}
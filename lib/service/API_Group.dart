

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:socialmediahq/model/GroupModel.dart';
import 'package:socialmediahq/service/const.dart';
import 'package:socialmediahq/view/Group/group_screen.dart';

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
        final GroupModel group = GroupModel.fromJson(json.decode(responseData));
        return group;
      }
      else
        return null;
    } else {
      // Handle error scenarios here
      return null;
    }
  }

  static Future<List<GroupModel>?> getAllGroups(String token) async {
    final url = Uri.parse('$baseUrl/group/');
    final headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      List<GroupModel> groups = responseData.map((data) => GroupModel.fromJson(data)).toList();
      return groups;
    } else {
      // Handle error scenarios here
      return null;
    }
  }



}
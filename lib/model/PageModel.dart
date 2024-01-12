


import 'package:socialmediahq/model/UsersEnity.dart';

import 'PostModel.dart';

class PageModel{
  final int? id;
  final String? name;
  final String? description;
  final String? Avatar;
  final DateTime? createDate;
  final DateTime? updateDate;
  final List<PostModel>? listPost;
  final int? adminId;

  PageModel({
    required this.name,
    required this.id,
    required this.description,
    required this.Avatar,
    required this.createDate,
    required this.updateDate,
     this.listPost,
    required this.adminId,
});

  factory PageModel.fromJson(Map<String, dynamic> json){
    List<PostModel> listPost = [];

      listPost = (json['listPost'] as List)
          .map((item) => PostModel.fromJson(item)).toList();
    return PageModel(
      id: json['id'] ?? 0,
      createDate: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updateDate: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      description: json['description'] ?? '',
      Avatar: json['avatar'] ?? '',
      listPost: listPost,
      name: json['name'] ?? '',
      adminId: json['adminId'] ?? 0,
    );
  }




}



import 'package:socialmediahq/model/UsersEnity.dart';

class PageModel{
  final int? id;
  final String? name;
  final String? description;
  final String? Avatar;
  final DateTime? createDate;
  final DateTime? updateDate;
  final int? adminId;

  PageModel({
    required this.name,
    required this.id,
    required this.description,
    required this.Avatar,
    required this.createDate,
    required this.updateDate,
    required this.adminId,
});

  factory PageModel.fromJson(Map<String, dynamic> json){
    return PageModel(
      id: json['id'] ?? 0,
      createDate: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updateDate: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      description: json['description'] ?? '',
      Avatar: json['avatar'] ?? '',
      name: json['name'] ?? '',
      adminId: json['adminId'] ?? 0,
    );
  }




}
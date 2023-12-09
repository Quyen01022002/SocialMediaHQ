import 'dart:convert';

import 'UserModel.dart';

class GroupModel {
  final int? id;
  final String? name;
  final String? description;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final List<UserMember> listMembers;

  GroupModel({
   required this.name,
    required this.id,
    required this.createdDate,
    required this.description,
    required this.updatedDate,
    required this.listMembers,

});

  factory GroupModel.fromJson(Map<String, dynamic> json){
    //final user = UserMember.fromJson(json['adminId']);
    List<UserMember> listUser = [];
    if (json['payload']['groupMembers'] == null)
      listUser= [];
    else
      listUser = (json['payload']['groupMembers'] as List)
    .map((item) => UserMember.fromJson(item)).toList();
    return GroupModel(
      id: json['payload']['id'] ?? 0,
        createdDate: json['payload']['createdAt'] != null ? DateTime.parse(json['payload']['createdAt']) : null,
        updatedDate: json['payload']['updatedAt'] != null ? DateTime.parse(json['payload']['updatedAt']) : null,
      description: json['payload']['description'] ?? '',
      name: json['payload']['name'] ?? '',
      listMembers: listUser
    );


  }



}
class UserMember {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String profilePicture;

  UserMember({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.profilePicture,
  });

  factory UserMember.fromJson(Map<String, dynamic> json) {
    return UserMember(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      phone: json['phone'] ?? "" ,
      email: json['email'] ?? "",
      profilePicture: json['profilePicture'] ?? "",
    );

  }
}
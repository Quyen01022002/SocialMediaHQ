import 'dart:convert';

import 'package:socialmediahq/model/PostModel.dart';
import 'package:socialmediahq/model/UsersEnity.dart';

List<UserProfile> userListFromJson(String val) =>
    List<UserProfile>.from(json.decode(val)['data']);

class UserProfile {
  final int? id;
  final String? first_name;
  final String? last_name;
  final String? email;
  final String? phone;
  final String? avatarUrl;
  final int? countFriend;
  final List<PostModel>? listpost;
  final List<UserEnity>? friends;

  UserProfile({
    this.id,
    this.first_name,
    this.last_name,
    this.email,
    this.phone,
    this.avatarUrl,
    this.countFriend,
    this.listpost,
    this.friends,
  });


  factory UserProfile.fromJson(Map<String, dynamic> json) {

    final listPost = (json['postList'] as List)
        .map((item) => PostModel.fromJson(item))
        .toList();
    final friendships = (json['friendships'] as List)
        .map((item) => UserEnity.fromJson(item))
        .toList();

    return UserProfile(
      id: json["id"] ?? 0,
      first_name: json["firstName"] ?? "",
      last_name: json["lastName"] ?? "",
      email: json["email"] ?? "",

      phone: json["phone"] ?? "",
      avatarUrl: json["profilePicture"] ?? "",
      countFriend: json["countFriend"] ?? 0,
      listpost: listPost,
      friends:friendships,
    );
  }
}

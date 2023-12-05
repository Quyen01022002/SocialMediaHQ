import 'dart:convert';

List<UserProfile> userListFromJson(String val) =>
    List<UserProfile>.from(json.decode(val)['data']);

class UserProfile {
  final int? user_id;
  final String? first_name;
  final String? last_name;
  final String? avatarUrl;
  final int? countfollow;
  final int? countfollowing;
  final int? postquan;

  UserProfile({
    this.user_id,
    this.first_name,
    this.last_name,
    this.avatarUrl,
    this.countfollow,
    this.countfollowing,
    this.postquan,
  });

  factory UserProfile.fromJson(Map<String, dynamic> data) => UserProfile(
        user_id: data.containsKey("user_ID") ? data["user_ID"] : 0,
        first_name: data["first_name"] ?? "",
        last_name: data["last_name"] ?? "",
        avatarUrl: data["profile_picture"] ?? "",
        countfollow: data["countfollow"] ?? 0,
        countfollowing: data["countfollowing"] ?? 0,
        postquan: data["postquan"] ?? 0,
      );
}

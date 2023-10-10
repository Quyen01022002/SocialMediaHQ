import 'dart:convert';

List<UserEnity> userListFromJson(String val) =>
    List<UserEnity>.from(json.decode(val)['data']);

class UserEnity {
  final int? user_id;
  final String? first_name;
  final String? last_name;
  final String? email;
  final bool? is_email;
  final String? phone;
  final bool? is_phone;
  final String? password_hash;
  final String? hash;
  final String? avatarUrl;
  final bool? is_actived;
  final DateTime? created_at;
  final DateTime? updated_at;

  UserEnity({
    this.user_id,
    this.first_name,
    this.last_name,
    this.email,
    this.is_email,
    this.phone,
    this.is_phone,
    this.password_hash,
    this.hash,
    this.avatarUrl,
    this.is_actived,
    this.created_at,
    this.updated_at,
  });

  factory UserEnity.fromJson(Map<String, dynamic> data) => UserEnity(
        user_id: data.containsKey("user_ID") ? data["user_ID"] : 0,
        first_name: data["first_name"] ?? "",
        last_name: data["last_name"] ?? "",
        email: data["email"] ?? "",
        is_email: data["is_email"] ?? false,
        phone: data["phone"] ?? "",
        is_phone: data["is_phone"] ?? false,
        password_hash: data["password_hash"] ?? "",
        hash: data["hash"] ?? "",
        avatarUrl: data["avatarUrl"] ?? "",
        is_actived: data["is_actived"] ?? false,
        created_at:
            DateTime.tryParse(data["created_at"] ?? "") ?? DateTime.now(),
        updated_at:
            DateTime.tryParse(data["updated_at"] ?? "") ?? DateTime.now(),
      );
}

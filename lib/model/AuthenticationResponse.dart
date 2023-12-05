import 'dart:convert';

List<AuthenticationResponse> userListFromJson(String val) =>
    List<AuthenticationResponse>.from(json.decode(val)['data']);

class AuthenticationResponse {
  final int? id;
  final String? email;
  final String? token;

  AuthenticationResponse({
    this.id,
    this.email,
    this.token,
  });

  factory AuthenticationResponse.fromJson(Map<String, dynamic> data) => AuthenticationResponse(
    id: data["id"] ?? 0,
    email: data["email"] ?? "",
    token: data["token"] ?? "",

  );
}

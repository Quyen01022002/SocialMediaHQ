import 'dart:convert';

List<PostModel> postModelListFromJson(String jsonString) {
  final jsonData = json.decode(jsonString) as List;
  return jsonData.map((item) => PostModel.fromJson(item)).toList();
}

class PostModel {
  final Post post;
  final List<Picture> listImg;

  PostModel({
    required this.post,
    required this.listImg,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final post = Post.fromJson(json['post']);
    final listImg = (json['listImg'] as List)
        .map((item) => Picture.fromJson(item))
        .toList();

    return PostModel(
      post: post,
      listImg: listImg,
    );
  }
}

class Post {
  final int post_id;
  final String first_name;
  final String last_name;
  final String profile_picture;
  final String content_post;
  final int timestamp;
  final bool status;

  Post({
    required this.post_id,
    required this.first_name,
    required this.last_name,
    required this.profile_picture,
    required this.content_post,
    required this.timestamp,
    required this.status,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      post_id: json['post_id'] ?? 0,
      first_name: json['first_name'] ?? "",
      last_name: json['last_name'] ?? "",
      profile_picture: json['profile_picture'] ?? "",
      content_post: json['content_post'] ?? "",
      timestamp: json['timestamp'] ?? 0,
      status: json['status'] == "true",
    );
  }
}

class Picture {
  final int pic_id;
  final int post_id;
  final String link_picture;

  Picture({
    required this.pic_id,
    required this.post_id,
    required this.link_picture,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      pic_id: json['pic_id'] ?? 0,
      post_id: json['post_id'] ?? 0,
      link_picture: json['link_picture'] ?? "",
    );
  }
}

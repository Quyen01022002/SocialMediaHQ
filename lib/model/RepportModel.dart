import 'package:socialmediahq/model/UsersEnity.dart';

import 'PostModel.dart';

class ReportModel{
  final int id;
  final CreateBy reporterID;
  final PostModel reportedPostID;
  final String reason;
  final String? timestamp;
  final String? status;

  ReportModel({
    required this.id,
    required this.reporterID,
    required this.reportedPostID,
    required this.reason,
    required this.timestamp,
    required this.status,
});

  factory ReportModel.fromJson(Map<String, dynamic> json){
    final createBy = CreateBy.fromJson(json['reporterID']);
    final Post = PostModel.fromJson(json['reportedPostID']);

    return ReportModel(
      id: json['id'] ?? 0,
      reporterID: createBy,
      reportedPostID: Post,
      reason: json['reason'] ?? '',
      timestamp: json['timestamp'] ?? '',
      status: json['status'] ?? '',
    );
  }




}
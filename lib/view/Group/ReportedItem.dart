import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/controller/HomeController.dart';

class ReportedItem extends StatefulWidget {
  final String reportedBy;
  final int id;
  final String reason;
  final String imageUrl; // Đường dẫn đến hình ảnh của mục

  ReportedItem({
    required this.reportedBy,
    required this.id,
    required this.reason,
    required this.imageUrl,
  });

  @override
  _ReportedItemState createState() => _ReportedItemState();
}

class _ReportedItemState extends State<ReportedItem> {
  final HomeController homeGroupController =
  Get.put(HomeController());
  late bool stateAccept=false;
  late bool stateDeny=false;
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            widget.imageUrl,
            height: 200.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Báo cáo bởi: ${widget.reportedBy}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text('Lý do báo cáo: ${widget.reason}'),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        homeGroupController.postid.value=widget.id;
                        homeGroupController.DeletePost();
                        setState(() {
                          stateAccept=true;
                        });
                      },
                      child: stateAccept==false?Text('Chấp nhận'):Text('Đã chấp nhận'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        homeGroupController.DeleteReport(widget.id);
                        setState(() {
                          stateDeny=true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // Màu đỏ cho nút từ chối
                      ),
                      child: stateDeny?Text('Từ chối'):Text('Đã từ chối'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'ReportedItem.dart';

class ApprovalItem extends StatelessWidget {
  final String userName;
  final String content;

  ApprovalItem({required this.userName, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/default_avatar.jpg'), // Thay đổi thành đường dẫn hoặc widget của bạn
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                Text(
                  content,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Xử lý khi nút được nhấn (phê duyệt)
                },
                style: ElevatedButton.styleFrom(primary: Colors.green),
                child: Text('Phê Duyệt'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Xử lý khi nút được nhấn (từ chối)
                },
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: Text('Từ Chối'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GroupManagementPage extends StatefulWidget {
  @override
  _GroupManagementPageState createState() => _GroupManagementPageState();
}

class _GroupManagementPageState extends State<GroupManagementPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Quản lý nhóm"),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: "Báo cáo"),
              Tab(text: "Duyệt Bài"),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 16, 0, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tên Nhóm",
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          Text("Nhóm công khai . 2 thành viên")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Tab 1: Báo cáo
                    ListView(
                      children: [
                        ApprovalItem(
                          userName: 'User1',
                          content: 'Nội dung cần phê duyệt 1...',
                        ),
                        ApprovalItem(
                          userName: 'User2',
                          content: 'Nội dung cần phê duyệt 2...',
                        ),
                        // Add more ApprovalItem widgets as needed
                      ],
                    ),
                    // Tab 2: Duyệt Bài
                    ListView(
                      children: [
                        ReportedItem(
                          id: 1,
                          imageUrl: '',
                          reason: '',
                          reportedBy:'' ,
                        ),
                        ApprovalItem(
                          userName: 'User4',
                          content: 'Nội dung cần duyệt bài 2...',
                        ),
                        // Add more ApprovalItem widgets as needed
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}


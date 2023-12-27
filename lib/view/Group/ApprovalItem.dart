import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/Group/HomeGroupController.dart';
import 'ReportedItem.dart';


class GroupManagementPage extends StatefulWidget {
  @override
  _GroupManagementPageState createState() => _GroupManagementPageState();
}

class _GroupManagementPageState extends State<GroupManagementPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final HomeGroupController homeGroupController =
      Get.put(HomeGroupController());

  @override
  void initState() {
    super.initState();
    homeGroupController.GetOneGroup;
    homeGroupController.loadReport(homeGroupController.group_id.value);
    _tabController = TabController(length: 1, vsync: this);
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
                            homeGroupController.nameGroup.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          Text("Nhóm công khai . " +
                              homeGroupController.listUserMembers!.length
                                  .toString() +
                              " thành viên")
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
                   ListView.builder(
                        itemCount: homeGroupController.listReport.length,
                        itemBuilder: (context, index) {
                          return ReportedItem(
                            id: homeGroupController.listReport[index].id,
                            imageUrl: homeGroupController.listReport[index].reportedPostID.listAnh[0].link_picture,
                            reason: homeGroupController.listReport[index].reason,
                            reportedBy: homeGroupController.listReport[index].reporterID.firstName +
                                " " +
                                homeGroupController.listReport[index].reporterID.lastName,
                          );
                        },
                      ),

                    // Tab 2: Duyệt Bài
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

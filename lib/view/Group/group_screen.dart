import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/view/Group/CreateGroup.dart';
import 'package:socialmediahq/view/Group/HomeGroup.dart';

import '../../controller/Group/HomeGroupController.dart';
import '../../model/GroupModel.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}


class Group{
  final int idgroup;
  final String name;
  final String avatar;
  Group(this.idgroup,this.name, this.avatar);

}

class _GroupScreenState extends State<GroupScreen>  with SingleTickerProviderStateMixin {
  final HomeGroupController homeGroupController = Get.put(HomeGroupController());

  final List<Group> listgroups = [
    Group(1,'Nhóm tự kỉ chat một mình', 'assets/images/facebook.png'),
    Group(1,'Nhóm tùm lum tùm la', 'assets/images/google.png'),
    Group(1,'Nhóm khác', 'assets/images/backgourd.png'),
  ];

  final List<Group> listgroup =[];
  final List<Group> listgroupJoin = [];
  Stream<List<GroupModel>>? groupStream;
  Stream<List<Group>>? listgroupStream;
  Stream<List<GroupModel>>? groupJoinStream;
  Stream<List<Group>>? listgroupJoinStream;
  Future<void> _mapGroupModelToGroupClass() async {
    if (homeGroupController.groups!= null) {
      homeGroupController.groups!.forEach((element) {
        Group group = Group(element.id ?? 0,
            element.name ?? '',
            element.description ?? '');
        listgroup.add(group);
      });
    }
    if (homeGroupController.groupsJoin!= null) {
      homeGroupController.groupsJoin!.forEach((element) {
        Group group = Group(element.id ?? 0,
            element.name ?? '',
            element.description ?? '');
        listgroupJoin.add(group);
      });
    }


  }
  Future<void> _mapGroupModelToGroup(List<GroupModel> list) async {
    if (list!= null) {
      list!.forEach((element) {
        Group group = Group(element.id ?? 0,
            element.name ?? '',
            element.description ?? '');
        listgroup.add(group);
      });

    }
  }
  Future<void> _mapGroupModelToGroupJoin(List<GroupModel> list) async {
    if (list!= null) {
      list!.forEach((element) {
        Group group = Group(element.id ?? 0,
            element.name ?? '',
            element.description ?? '');
        listgroupJoin.add(group);
      });

    }
  }
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _startTimer();
  }
  late Timer _timer;
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      // Gọi hàm cần thiết ở đây
      homeGroupController.loadGroupsOfAdmin();
      homeGroupController.loadGroupsJoin();
      groupStream = homeGroupController.groupsStream; // Đây là Stream mà bạn cần theo dõi
      // Cập nhật danh sách nhóm khi Stream thay đổi
      groupStream?.listen((List<GroupModel>? updatedGroups) {
        if (updatedGroups != null) {
          setState(() {
            listgroup.clear();
            _mapGroupModelToGroup(updatedGroups);
          });
        }
      });
      groupJoinStream = homeGroupController.groupsJoinStream; // Đây là Stream mà bạn cần theo dõi
      // Cập nhật danh sách nhóm khi Stream thay đổi
      groupJoinStream?.listen((List<GroupModel>? updatedGroups) {
        if (updatedGroups != null) {
          setState(() {
            listgroupJoin.clear();
            _mapGroupModelToGroupJoin(updatedGroups);
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: false,
              pinned: true,
              backgroundColor: Color(0xFF8587F1),
              title: Text('Nhóm',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text('Thôi nhiều nhóm quá, tự tạo cho bản thân mình một nhóm "Thiên đường"',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CreateGroup()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white, // Đặt màu nền là màu trắng
                                side: BorderSide(width: 2, color: Color(0xFF8587F1)),// Đặt màu viền là màu đỏ
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Text(
                                    'Tạo nhóm mới',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),


                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        color: Colors.white,
                        child: TabBar(
                          controller: _tabController,
                          tabs: [
                            _buildTab('Nhóm của bạn'),
                            _buildTab('Đang tham gia'),
                          ],
                          indicator: BoxDecoration(
                            color: Color(0xFFF1F1FE),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          labelColor: Color(0xFF2F80ED),
                          unselectedLabelColor: Colors.black,
                        ),
                      ),
                    ),

                  ],
                ),
              ),

            ),
            SliverFillRemaining(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  // Tab 1 content
                 _buildTabContentForum(),
                  _buildTabContentPost(listgroupJoin),
                ],
              ),
            ),
          ]
      ),
    ));
  }
  Widget _buildTab(String title) {
    return Tab(
      child: Container(
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
  Widget _buildTabContentPost(List<Group> groupList) {
    return StreamBuilder<List<GroupModel>>(
      stream: groupJoinStream, // Sử dụng stream để cập nhật danh sách nhóm
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  homeGroupController.GetOneGroup(
                      context,
                      snapshot.data![index].id!
                  );
                  Future.delayed(Duration(milliseconds: 300), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeGroup()),
                    );
                  });
                },
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/facebook.png'),
                ),
                title: Text(snapshot.data![index].name.toString()),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
  Widget _buildTabContentForum() {
    return StreamBuilder<List<GroupModel>>(
      stream: groupStream, // Sử dụng stream để cập nhật danh sách nhóm
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  homeGroupController.GetOneGroup(
                    context,
                    snapshot.data![index].id!
                  );
                  Future.delayed(Duration(milliseconds: 300), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeGroup()),
                    );
                  });
                },
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/facebook.png'),
                ),
                title: Text(snapshot.data![index].name.toString()),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
  Widget _buildTabContentHotNews(List<Group> groupList) {
    return ListView.builder(
      itemCount: groupList.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            homeGroupController.GetOneGroup(context, groupList[index].idgroup);
          },
          leading: CircleAvatar(
            backgroundImage: AssetImage(groupList[index].avatar),
          ),
          title: Text(groupList[index].name),
        );
      },
    );
  }




}

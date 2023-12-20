import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/component/Post/create_post.dart';
import 'package:socialmediahq/controller/Group/HomeGroupController.dart';
import 'package:socialmediahq/view/Group/AddMembers.dart';
import 'package:socialmediahq/view/Group/ListMembersGroup.dart';
import 'package:socialmediahq/view/Group/UpdateGroup.dart';
import 'package:socialmediahq/view/Group/group_screen.dart';

import '../../component/Post/Home_Post.dart';
import '../../component/Post/create_post_Group.dart';
import '../../model/GroupModel.dart';

class HomeGroup extends StatefulWidget {
  const HomeGroup({super.key});

  @override
  State<HomeGroup> createState() => _HomeGroupState();
}

class UserAvatar {
  final int id;
  final String name;
  final String avatar;
  bool check;

  UserAvatar(this.id, this.name, this.avatar, this.check);
}

class _HomeGroupState extends State<HomeGroup>
    with SingleTickerProviderStateMixin {
  final HomeGroupController homeGroupController =
      Get.put(HomeGroupController());
  late TabController _tabController;
  final List<UserAvatar> userList = [
    UserAvatar(1, 'Đỗ Duy Hào', 'assets/images/facebook.png', false),
    UserAvatar(1, 'Trần Bửu Quyến', 'assets/images/google.png', false),
    UserAvatar(1, 'Văn Bá Trung Thành', 'assets/images/backgourd.png', false),
    UserAvatar(1, 'Đỗ Duy Hào', 'assets/images/facebook.png', false),
    UserAvatar(1, 'Văn Bá Trung Thành', 'assets/images/backgourd.png', false),
    UserAvatar(1, 'Văn Bá Trung Thành', 'assets/images/backgourd.png', false),
    UserAvatar(1, 'Văn Bá Trung Thành', 'assets/images/backgourd.png', false),
  ];
  Stream<GroupModel>? groupCurrent;
  GroupModel? group;
  late RxString curnetUser = "".obs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    initCurrentUser();
    _startTimer();
  }

  void initCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    curnetUser = (prefs.getString('Avatar') ??
            "https://inkythuatso.com/uploads/thumbnails/800/2023/03/10-anh-dai-dien-trang-inkythuatso-03-15-27-10.jpg")
        .obs;
    print(curnetUser);
  }

  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Gọi hàm cần thiết ở đây
      _loadData();
      groupCurrent =
          homeGroupController.groupCurrent; // Đây là Stream mà bạn cần theo dõi
      // Cập nhật danh sách nhóm khi Stream thay đổi
      groupCurrent?.listen((GroupModel? currentGroup) {
        if (currentGroup != null) {
          setState(() {
            group = currentGroup;
          });
        }
      });
    });
  }

  void _loadData() async {
    await homeGroupController.GetOneGroup;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          backgroundColor: Color(0xFF8587F1),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                showPopupMenu(context);
              },
            ),
          ],
          flexibleSpace: StreamBuilder<GroupModel>(
            stream: groupCurrent,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FlexibleSpaceBar(
                  title: Text(
                    snapshot.data!.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  background: Image.asset(
                    'assets/images/backgroud_profile_page.png',
                    fit: BoxFit.cover,
                  ),
                  titlePadding: EdgeInsets.only(left: 20, bottom: 20),
                );
              } else {
                return FlexibleSpaceBar(
                  title: Text(
                    "Loading...",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  background: Image.asset(
                    curnetUser.value,
                    fit: BoxFit.cover,
                  ),
                  titlePadding: EdgeInsets.only(left: 20, bottom: 20),
                );
              }
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<GroupModel>(
                  stream: groupCurrent,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          snapshot.data!.description.toString(),
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Loading...',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      );
                    }
                  },
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListMemberGroup()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Danh sách thành viên trong nhóm >',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      StreamBuilder<GroupModel>(
                          stream: groupCurrent,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                children: [
                                  for (var i = 0;
                                      i < snapshot.data!.listMembers.length;
                                      i++)
                                    if (i < 5)
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: ClipOval(
                                            child: Image.network(
                                              snapshot.data!.listMembers[i]
                                                  .profilePicture,
                                              width: 40,
                                              height: 40,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                  //if (homeGroupController.listUserMembers!.length > 5)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ListMemberGroup()),
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: ClipOval(
                                          child: Container(
                                            color: Colors.grey,
                                            // Màu sẽ hiển thị dấu "xem thêm"
                                            width: 40,
                                            height: 40,
                                            child: Center(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Loading members...',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }
                          }),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      // Align(
                      //   child: Container(
                      //     child: ElevatedButton(
                      //       onPressed: () {
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(builder: (context) => ListMemberGroup()),
                      //         );
                      //
                      //       },
                      //       style: ElevatedButton.styleFrom(
                      //
                      //         backgroundColor: Color(0xFF8587F1),
                      //       ),
                      //       child: Padding(
                      //         padding: const EdgeInsets.fromLTRB(10,10,10,10),
                      //         child: Text('Quản lý'),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              homeGroupController.loadFriends(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF8587F1),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Text('Thêm thành viên'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 15, // Chiều cao của thanh ngang
                  width: 500, // Độ dày của thanh ngang
                  color: Color(0xC0C0C0C0),
                ),
                Card(
                  elevation: 3,
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(curnetUser.value),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      child: CreatePostGroup(
                                        statepost: false,
                                        idGroup:
                                            homeGroupController.group_id.value,
                                      ),
                                    ),
                                  );
                                },
                                decoration: InputDecoration(
                                  hintText: "Bạn nghĩ gì?",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Handle post button click

                                // Add logic to post the content to your backend or perform other actions
                              },
                              child: Text("Đăng"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 15, // Chiều cao của thanh ngang
                  width: 500, // Độ dày của thanh ngang
                  color: Color(0xC0C0C0C0),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    color: Colors.white,
                    child: TabBar(
                      controller: _tabController,
                      tabs: [
                        _buildTab('Ghim'),
                        _buildTab('Bài viết'),
                        _buildTab('Phương tiện'),
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
              _buildTabContentHotNews(''),
              _buildTabContentForum(''),
              _buildTabContentPost('content'),
            ],
          ),
        ),
        /*SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              childCount: 50, // Thay đổi số lượng phần tử theo nhu cầu của bạn
            ),
          ),*/
      ]),
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

  Widget _buildTabContentPost(String content) {
    return Center(
      child: homeGroupController.listPost == []
          ? Image.asset("assets/images/khongbaiviet.png")
          : ListView.builder(

              itemCount: homeGroupController.listPost.length,
              itemBuilder: (context, index) {
                final post = homeGroupController.listPost[index];
                return AnimatedOpacity(
                  duration: Duration(milliseconds: 100),
                  opacity: 1,
                  child: Home_Post(postModel: post),
                );
              },
            ),
    );
  }

  Widget _buildTabContentForum(String content) {
    return Center(child: Image.asset("assets/images/forum_page.jpg"));
  }

  Widget _buildTabContentHotNews(String content) {
    return Center(child: Image.asset("assets/images/hot_news_page.png"));
  }

  Future<void> showPopupMenu(BuildContext context) async {
    if (await homeGroupController.isAdmin.value == true) {
      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(100, kToolbarHeight, 0, 0),
        items: <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'update',
            child: Text('Cập nhật'),
          ),
          const PopupMenuItem<String>(
            value: 'delete',
            child: Text('Xóa nhóm'),
          ),
        ],
      ).then((value) {
        // Xử lý khi chọn một tùy chọn
        if (value == 'update') {
          // Thực hiện hành động update
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdateGroup()),
          );
        } else if (value == 'delete') {
          // Thực hiện hành động delete
          showDeleteOption(context);
        }
      });
    } else {
      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(100, kToolbarHeight, 0, 0),
        items: <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'outgroup',
            child: Text('Rời nhóm'),
          ),
        ],
      ).then((value) {
        // Xử lý khi chọn một tùy chọn
        if (value == 'outgroup') {
          // Thực hiện hành động outgroup
          showOutGroupOption(context);
        }
      });
    }
  }

  void showDeleteOption(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Xác nhận"),
          content: Text("Bạn có chắc chắn muốn xóa nhóm này?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: Text("Không"),
            ),
            TextButton(
              onPressed: () {
                // Thực hiện xóa nhóm ở đây
                homeGroupController.deleteGroup(
                    context, homeGroupController.group_id.value);
                // Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: Text("Có"),
            ),
          ],
        );
      },
    );
  }

  void showOutGroupOption(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Xác nhận"),
          content: Text("Bạn muốn rời khỏi nhóm này?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: Text("Không"),
            ),
            TextButton(
              onPressed: () {
                homeGroupController.outGroupByMe(context);
                //Navigator.of(context).popUntil(GroupScreen() as RoutePredicate);
                // Navigator.of(context).pop();
                // //Navigator.of(context).pop();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => GroupScreen()),
                // );
              },
              child: Text("Có"),
            ),
          ],
        );
      },
    );
  }
}

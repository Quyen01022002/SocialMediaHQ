import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/controller/PageHomeController.dart';
import 'package:socialmediahq/view/Page/UpdatePage.dart';

import '../../model/PageLoad.dart';
import '../../model/PageModel.dart';

class ProPage extends StatefulWidget {
  const ProPage({super.key});

  @override
  State<ProPage> createState() => _ProPageState();
}

class _ProPageState extends State<ProPage> with SingleTickerProviderStateMixin {

  final PageHomeController pageHomeController = Get.put(PageHomeController());
  late TabController _tabController;
  Stream<PageLoad>? pageLoadCurrent;
  PageLoad? pageLoad;
  @override
  void initState() {
    super.initState();
     _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
     _startTimer();
  }
  late Timer _timer;
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Gọi hàm cần thiết ở đây
      pageLoadCurrent = pageHomeController.pageLoadCurrent;
      // Đây là Stream mà bạn cần theo dõi
      // Cập nhật danh sách nhóm khi Stream thay đổi
      pageLoadCurrent?.listen((PageLoad? currentGroup) {
        if (currentGroup != null) {
          setState(() {
            pageLoad = currentGroup;
          });
        }
      });
      print(pageLoad?.pageModel?.name);
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
      //resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children:[
                Container(
                decoration: BoxDecoration(color: Colors.white),
                child: StreamBuilder<PageLoad>(
                  stream: pageLoadCurrent,
                  builder: (context, snapshot) {
                    if (snapshot.hasData){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 280,
                          child: Stack(
                            children: [
                              Image.asset(
                                "assets/images/backgroud_profile_page.png",
                                fit: BoxFit.cover,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            80)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ClipOval(
                                        child: Image.asset(
                                          "assets/images/backgourd.png",
                                          width: 150,
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),

                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 5, left: 55, right: 15, bottom: 0),
                          margin: EdgeInsets.only(bottom: 0),
                          child: Column(
                            children: [
                              Text(snapshot.data!.pageModel!.name.toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,)
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 20, left: 25, right: 18),
                          child: Text(
                            snapshot.data!.pageModel!.description.toString(),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 25, top: 10),
                          child: Row(

                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(snapshot.data!.countLiked.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      Text(" Lượt thích"),
                                    ],
                                  ),
                                  if (snapshot.data!.isLiked == true)
                                  ElevatedButton(
                                    onPressed: () {
                                      // Xử lý khi nút 1 được nhấn
                                    },
                                    child: Text('Bỏ thích'),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      backgroundColor: Color(0xFF8587F1),
                                    ),

                                  ),
                                  if (snapshot.data!.isLiked == false)
                                    ElevatedButton(
                                      onPressed: () {
                                        // Xử lý khi nút 1 được nhấn
                                      },
                                      child: Text('Thích'),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        backgroundColor: Color(0xFF8587F1),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(width: 20,),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(snapshot.data!.countFollowing.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      Text(" Lượt theo dõi")
                                    ],
                                  ),
                                  if (snapshot.data!.isFollowing == true)
                                  ElevatedButton(
                                    onPressed: () {
                                      // Xử lý khi nút 1 được nhấn
                                      pageHomeController.unfollowPage(context);
                                    },
                                    child: Text('Hủy theo dõi'),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      backgroundColor: Color(0xFF8587F1),
                                    ),
                                  ),
                                  if (snapshot.data!.isFollowing == false)
                                    ElevatedButton(
                                      onPressed: () {
                                        // Xử lý khi nút 1 được nhấn
                                        pageHomeController.followPage(context);
                                      },
                                      child: Text('Theo dõi'),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        backgroundColor: Color(0xFF8587F1),
                                      ),
                                    ),
                                ],
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
                    );}
                    else
                      {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 280,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    "assets/images/backgroud_profile_page.png",
                                    fit: BoxFit.cover,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      left: 10,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                80)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ClipOval(
                                            child: Image.asset(
                                              "assets/images/backgourd.png",
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              ),

                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 5, left: 15, right: 15, bottom: 0),
                              margin: EdgeInsets.only(bottom: 0),
                              child: Column(
                                children: [
                                  Text("Loading....",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,)
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 25, top: 10),
                              child: Row(

                                children: [
                                  Text("8.3K",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  Text("Lượt thích"),
                                  Text("      2M",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  Text("Lượt theo dõi")
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 20, left: 18, right: 18),
                              child: Text(
                                "Loading.....",
                                textAlign: TextAlign.left,
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
                        );
                      }

                  }),

              ),
                Positioned(
                  top: 200,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      // Xử lý khi icon được nhấn
                      showPopupMenu(context);
                      // Hiển thị các tùy chọn hoặc thực hiện hành động cần thiết
                    },
                    child: Icon(
                      FontAwesomeIcons.bars, // Sử dụng icon ba gạch của Flutter
                      size: 30, // Điều chỉnh kích thước nếu cần
                      color: Colors.white, // Điều chỉnh màu sắc nếu cần
                    ),
                  ),
                ),]
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









        ],
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
  Widget _buildTabContentPost(String content) {
    return Center(
        child: Image.asset("assets/images/khongbaiviet.png")
    );
  }
  Widget _buildTabContentForum(String content) {
    return Center(
        child: Image.asset("assets/images/forum_page.jpg")
    );
  }
  Widget _buildTabContentHotNews(String content) {
    return Center(
        child: Image.asset("assets/images/hot_news_page.png")
    );
  }
  Future<void> showPopupMenu(BuildContext context) async {
    if (await true == true) {
      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(100, 200, 0, 0),
        items: <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'update',
            child: Text('Cập nhật'),
          ),
          const PopupMenuItem<String>(
            value: 'delete',
            child: Text('Xóa trang'),
          ),
        ],
      ).then((value) {
        // Xử lý khi chọn một tùy chọn
        if (value == 'update') {
          // Thực hiện hành động update
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdatePage()),
          );
        } else if (value == 'delete') {
          // Thực hiện hành động delete
          showDeleteOption(context);
        }
      });
    }
    else
    {
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
  pageHomeController.DeletePage(context);
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

              },
              child: Text("Có"),
            ),
          ],
        );
      },
    );
  }

}

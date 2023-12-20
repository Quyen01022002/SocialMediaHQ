import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/view/Page/CreatePage2.dart';
import 'package:socialmediahq/view/Page/HomePage.dart';
import 'package:socialmediahq/view/Page/ProPage.dart';

import '../../controller/Group/HomeGroupController.dart';
import '../../controller/PageHomeController.dart';
import '../../model/GroupModel.dart';
import '../../model/PageModel.dart';
import '../Group/CreateGroup.dart';
import '../Group/HomeGroup.dart';

class PageScreen extends StatefulWidget {
  const PageScreen({super.key});

  @override
  State<PageScreen> createState() => _PageScreenState();
}
class Page{
  final int idpage;
  final String name;
  final String avatar;
  Page(this.idpage,this.name, this.avatar);

}
class _PageScreenState extends State<PageScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  final PageHomeController pageHomeController = Get.put(PageHomeController());
  Stream<List<PageModel>>? allPageStream;
  List<PageModel>? allPage;
  Stream<List<PageModel>>? followPageStream;
  List<PageModel>? followPage;
  Stream<List<PageModel>>? likedPageStream;
  List<PageModel>? likedPage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _startTimer();
  }
  late Timer _timer;
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Gọi hàm cần thiết ở đây
      _loadData();
      allPageStream = pageHomeController.allPageStream;
      // Đây là Stream mà bạn cần theo dõi
      allPageStream?.listen((List<PageModel>? updatedGroups) {
        if (updatedGroups != null) {
          setState(() {
            allPage = updatedGroups;
          });
        }
      });

      followPageStream = pageHomeController.followingPageStream;
      // Đây là Stream mà bạn cần theo dõi
      followPageStream?.listen((List<PageModel>? updatedGroups) {
        if (updatedGroups != null) {
          setState(() {
            followPage = updatedGroups;
          });
        }
      });

      likedPageStream = pageHomeController.likedPageStream;
      // Đây là Stream mà bạn cần theo dõi
      likedPageStream?.listen((List<PageModel>? updatedGroups) {
        if (updatedGroups != null) {
          setState(() {
            likedPage = updatedGroups;
          });
        }
      });

      // Cập nhật danh sách nhóm khi Stream thay đổi

    });
  }

  void _loadData() async {
    await pageHomeController.loadPage();

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
              title: Text('Trang',
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
                            padding: EdgeInsets.only(top: 0),
                            child: ElevatedButton(
                              onPressed: () {
                                pageHomeController.GetOnePage(3, context);
                                Future.delayed(Duration(milliseconds: 300), () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CreatePage2()),
                                  );
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white, // Đặt màu nền là màu trắng
                                side: BorderSide(width: 2, color: Color(0xFF8587F1)),// Đặt màu viền là màu đỏ
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Text(
                                    'Tạo trang mới',
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
                          SizedBox(width: 100,),
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text('Khám phá các trang khác',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),),
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
                            _buildTab('Tất cả trang'),
                            _buildTab('Trang của bạn'),
                            _buildTab('Đang theo dõi'),
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
                  _buildTabContentAllPage(),
                  _buildTabContentOfUserAdmin(),
                  _buildTabContentFollowPage(),
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
  Widget _buildTabContentOfUserAdmin() {
    return StreamBuilder<List<PageModel>>(
      stream: likedPageStream, // Sử dụng stream để cập nhật danh sách nhóm
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  pageHomeController.GetOnePage(snapshot.data![index].id!, context);
                  Future.delayed(Duration(milliseconds: 300), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProPage()),
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
            child: Text(
              'Bạn chưa tạo trạng nào!'
            ),
          );
        }
      },
    );
  }
  Widget _buildTabContentAllPage() {
    return StreamBuilder<List<PageModel>>(
      stream: allPageStream, // Sử dụng stream để cập nhật danh sách nhóm
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  pageHomeController.GetOnePage(snapshot.data![index].id!, context);
                  Future.delayed(Duration(milliseconds: 300), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProPage()),
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
  Widget _buildTabContentFollowPage() {
    return StreamBuilder<List<PageModel>>(
      stream: followPageStream, // Sử dụng stream để cập nhật danh sách nhóm
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  pageHomeController.GetOnePage(snapshot.data![index].id!, context);
                  Future.delayed(Duration(milliseconds: 300), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProPage()),
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
            child: Text(
              'Bạn chưa theo dõi trang nào'
            )
          );
        }
      },
    );}
}

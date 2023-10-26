import 'dart:math';

import 'package:flutter/material.dart';

import 'package:socialmediahq/component/Home_Header.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
              height: 280,
                child: Stack(
                  children: [

                    Image.asset(
                      "assets/images/backgroud_profile_page.png",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Positioned(
                        bottom: 0,
                        left: 10,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(80)),
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
                padding: EdgeInsets.only(top:5, left: 15, right: 15,bottom: 0 ),
                margin: EdgeInsets.only(bottom: 0),
                child: Column(
                  children: [
                    Text("Đây là trang duy nhất của Ứng dụng MXH QH",
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
                padding: EdgeInsets.only(top: 20, left: 18, right: 18),


                child: Text(
                  "Giới thiệu về trang page sẽ nằm ở chỗ này!",
                  textAlign: TextAlign.left,
                ),


              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 15,     // Chiều cao của thanh ngang
                width: 500,     // Độ dày của thanh ngang
                color: Color(0xC0C0C0C0),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    tabs: [
                      _buildTab('Nổi bật'),
                      _buildTab('Bài viết'),
                      _buildTab('Diễn đàn'),
                      _buildTab('Hình ảnh'),
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
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildTabContentHotNews('Content for Tab 1'),
                    _buildTabContentPost('Content for Tab 2'),
                    _buildTabContentForum('Content for Tab 2'),
                    _buildTabContentAlbum('Content for Tab 2')
                  ],
                ),
              ),

            ],
          ),

        ),
      ),
    );
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
  Widget _buildTabContentAlbum(String content) {
    return Center(
        child: Image.asset("assets/images/khongbaiviet.png")
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
}

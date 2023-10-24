import 'package:flutter/material.dart';
import 'package:socialmediahq/view/Group/AddMembers.dart';

class HomeGroup extends StatefulWidget {
  const HomeGroup({super.key});

  @override
  State<HomeGroup> createState() => _HomeGroupState();
}

class _HomeGroupState extends State<HomeGroup> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: Color(0xFF8587F1),
            flexibleSpace: FlexibleSpaceBar(
              title:

                  Text('Đây là nhóm duy nhất của Ứng dụng MXH QH',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,),


              background: Image.asset(
                'assets/images/backgroud_profile_page.png', // Đặt đường dẫn hình ảnh của bạn ở đây
                fit: BoxFit.cover,
              ),

              titlePadding: EdgeInsets.only(left: 20, bottom: 20),


            ),



          ),


        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(0),
            child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text('Danh sách thành viên trong nhóm >',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Row(
                      children: [

                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/facebook.png",
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: ClipOval(
                              child: Image.asset(
                                "assets/images/google.png",
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: ClipOval(
                              child: Image.asset(
                                "assets/images/post1.png",
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: EdgeInsets.only(left: 5),
                            child: ClipOval(
                              child: Image.asset(
                                "assets/images/backgourd.png",
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                      ],
                      )
                    ],
                  ),


                ),

                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(

                              backgroundColor: Color(0xFF8587F1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10,10,10,10),
                              child: Text('Quản lý'),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AddMembersGroup()),
                              );
                            },
                            style: ElevatedButton.styleFrom(

                              backgroundColor: Color(0xFF8587F1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10,10,10,10),
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
                  height: 15,     // Chiều cao của thanh ngang
                  width: 500,     // Độ dày của thanh ngang
                  color: Color(0xC0C0C0C0),
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


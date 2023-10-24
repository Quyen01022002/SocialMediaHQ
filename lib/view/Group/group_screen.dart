import 'package:flutter/material.dart';
import 'package:socialmediahq/view/Group/CreateGroup.dart';
import 'package:socialmediahq/view/Group/HomeGroup.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}


class Group{
  final String name;
  final String avatar;
  Group(this.name, this.avatar);

}

class _GroupScreenState extends State<GroupScreen>  with SingleTickerProviderStateMixin {


  final List<Group> listgroup = [
    Group('Nhóm tự kỉ chat một mình', 'assets/images/facebook.png'),
    Group('Nhóm tùm lum tùm la', 'assets/images/google.png'),
    Group('Nhóm khác', 'assets/images/backgourd.png'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
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
                            _buildTab('Chung'),
                            _buildTab('Nhóm của bạn'),
                            _buildTab('Khám phá'),
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
                  _buildTabContentHotNews(listgroup),
                 _buildTabContentForum(listgroup),
                  _buildTabContentPost(listgroup),
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
    return ListView.builder(
      itemCount: groupList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
        backgroundImage: AssetImage(groupList[index].avatar),
        ),
          title: Text(groupList[index].name),
        );
      },
    );
  }
  Widget _buildTabContentForum(List<Group> groupList) {
    return ListView.builder(
      itemCount: groupList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(groupList[index].avatar),
          ),
          title: Text(groupList[index].name),
        );
      },
    );
  }
  Widget _buildTabContentHotNews(List<Group> groupList) {
    return ListView.builder(
      itemCount: groupList.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            // Chuyển đến trang mục tiêu khi nhấn vào ListTile
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return HomeGroup(); // Trang mục tiêu
            }));
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

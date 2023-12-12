import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialmediahq/component/Post/Home_Post.dart';
import 'package:socialmediahq/controller/ProfileController.dart';
import 'package:socialmediahq/view/Settings/chooseimage.dart';

import '../../model/UsersEnity.dart';

class ProfileScreenOther extends StatefulWidget {
  final int id;
  const ProfileScreenOther({Key? key,required this.id}) : super(key: key);

  @override
  State<ProfileScreenOther> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreenOther> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFriend = false;
  double opacity = 0.0;
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.loadthongtinOther(widget.id);
    _tabController = TabController(length: 2, vsync: this);
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
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 440.0,
                floating: false,
                backgroundColor: Colors.white,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Image.asset(
                        "assets/images/backgourd.png",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: 220,
                      ),
                      Positioned(
                        bottom: 10,
                        left: 30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(500),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.bottomToTop,
                                      child: ChooseImage(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ClipOval(
                                    child: Obx(() => Image.network(
                                      profileController.Avatar.toString(),
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Obx(() => Text(
                                profileController.fisrt_name.toString() + " " + profileController.last_name.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),)
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (!isFriend) // Nếu chưa là bạn bè, hiển thị nút "Thêm Bạn Bè"
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF8587F1),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        isFriend = false;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(45, 10, 45, 10),
                                      child: Text("Thêm Bạn Bè"),
                                    ),
                                  ),
                              ],
                            ),
                            Text(
                              "Hồ Chí Minh, Việt Nam",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(26, 16, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildStat(profileController.post.toString(), 'Bài Viết'),
                                      _buildStat(profileController.follow.toString(), 'Người Theo Dõi'),
                                      _buildStat(profileController.following.toString(), 'Đang Theo Dõi'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ];
          },
          body: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    color: Colors.white,
                    child: TabBar(
                      controller: _tabController,
                      tabs: [
                        _buildTab('Bài Viết'),
                        _buildTab('Bạn Bè'),
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
                      Obx(() => _buildTabPost('Nội dung cho Tab Bài Viết')),
                      _buildTabContent(profileController.listFriends),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String title) {
    return Tab(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTabPost(String content) {
    print("Số bài đăng: ${profileController.listPost.length}");
    return Container(
      height: MediaQuery.of(context).size.height - 340, // Điều chỉnh chiều cao theo cần thiết
      child: ListView.builder(
        itemCount: profileController.listPost.length,
        itemBuilder: (context, index) {
          final post = profileController.listPost[index];
          return Home_Post(postModel: post);
        },
      ),
    );
  }

  Widget _buildTabContent(List<UserEnity> friendList) {
    return Obx(() => GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Số lượng cột
        crossAxisSpacing: 8.0, // Khoảng cách giữa các cột
        mainAxisSpacing: 8.0, // Khoảng cách giữa các dòng
      ),
      itemCount: friendList.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildFriendItem(friendList[index]);
      },
    ),);
  }

  Widget _buildFriendItem(UserEnity friend) {
    print("Số bài đăng: ${friend.avatarUrl}");
    return SingleChildScrollView(
      child: Column(
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
              child: Image.network(
                friend.avatarUrl.toString(),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            friend.first_name.toString() + " " + friend.last_name.toString(),
            textAlign: TextAlign.center,
            maxLines: 2, // Adjust the number of lines you want to display
            overflow: TextOverflow.ellipsis, // Specify how to handle overflow
          ),
        ],
      ),
    );

  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }

}




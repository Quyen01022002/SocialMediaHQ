import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialmediahq/controller/ProfileController.dart';
import 'package:socialmediahq/model/UsersProfile.dart';
import 'package:socialmediahq/view/Settings/chooseimage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState()  {
    super.initState();
     _loadData();
    _tabController = TabController(length: 2, vsync: this);
  }
  void _loadData() async {
    // Công việc bất đồng bộ ở đây
    await profileController.loadthongtin;

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
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Container(
                height: 200,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/Profile-back.png",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Positioned(
                        bottom: 0,
                        left: 146,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                          child: GestureDetector(
                            onTap: ()
                            {
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
                                child: Image.asset(
                                  "assets/images/backgourd.png",
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 26.0),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 70),
                            child: Text(
                              "Trang cá nhân",
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                profileController.fisrt_name.toString()+profileController.last_name.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                "Hồ Chí Minh, Việt Nam",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(56, 16, 56, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              profileController.post.toString(),
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text("Post")
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              profileController.follow.toString(),
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text("Follower")
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              profileController.following.toString(),
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text("Following")
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    tabs: [
                      _buildTab(profileController.post.toString()+' Bài Viết'),
                      _buildTab('0 Bạn bè'),
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

              // TabBarView tùy chỉnh
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildTabContent('Content for Tab 1'),
                    _buildTabContent('Content for Tab 2'),
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
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
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

  Widget _buildTabContent(String content) {
    return Center(child: Image.asset("assets/images/khongbaiviet.png"));
  }
}

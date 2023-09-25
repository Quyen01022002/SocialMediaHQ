import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Trần Bửu Quyến",
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
                decoration: BoxDecoration(
                  color: Color(0xFFF3F5F7),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(56, 16, 56, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '150 ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Followers',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: '1 ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Following',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(98, 20, 98, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/facebook1.png"),
                  Image.asset("assets/images/globe1.png"),
                  Image.asset("assets/images/u_instagram.png")
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    _buildTab('10 Bài Viết'),
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
    return Center(
      child: Image.asset("assets/images/khongbaiviet.png")
    );
  }
}

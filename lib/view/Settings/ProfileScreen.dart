import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialmediahq/component/Post/Home_Post.dart';
import 'package:socialmediahq/controller/ProfileController.dart';
import 'package:socialmediahq/model/UsersEnity.dart';
import 'package:socialmediahq/view/Settings/DisplayBackGroudImagePage.dart';
import 'package:socialmediahq/view/Settings/chooseimage.dart';

import 'DisplaySelectedImagePage.dart';
import 'EditProfileScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFriend = false;
  double opacity = 0.0;
  ProfileController profileController = Get.find();

  @override
  void initState() {
    super.initState();
    profileController.loadthongtin();
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
                      GestureDetector(
                        onTap: () {
                          final Name = profileController.fisrt_name.toString() +
                              " " +
                              profileController.last_name.toString();
                          _pickImageBackGroud(context, ImageSource.gallery,
                              Name, profileController.Avatar.toString());
                        },
                        child: Obx(() {
                          final imageUrl =
                              profileController.BackGround.toString();
                          if (imageUrl.startsWith('http')) {
                            // Đây là một URL hợp lệ
                            return Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: 220,
                            );
                          } else {
                            // Đây có thể là đường dẫn cục bộ
                            return Image.asset(
                              "assets/images/backgourd.png",
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: 220,
                            );
                          }
                        }),
                      ),
                      Obx(
                        () => Positioned(
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
                                    _pickImage(context, ImageSource.gallery);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ClipOval(
                                      child: Obx(
                                        () {
                                          final imageUrl = profileController
                                              .Avatar.toString();

                                          if (imageUrl.startsWith('http')) {
                                            // Đây là một URL hợp lệ
                                            return Image.network(
                                              imageUrl,
                                              width: 120,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            );
                                          } else {
                                            // Đây có thể là đường dẫn cục bộ
                                            return Image.asset(
                                              "assets/images/backgourd.png",
                                              width: 120,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Obx(
                                    () => Text(
                                      profileController.fisrt_name.toString() +
                                          " " +
                                          profileController.last_name
                                              .toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  )),
                              Text(
                                "Hồ Chí Minh, Việt Nam",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // Add your navigation logic here
                                  // For example, navigate to the edit profile page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProfileScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.edit, color: Colors.blue),
                                      SizedBox(width: 8),
                                      Text(
                                        'Chỉnh sửa thông tin',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                                child: Container(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(26, 16, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildStat(
                                            profileController.post.toString(),
                                            'Bài Viết'),
                                        _buildStat(
                                            profileController.follow.toString(),
                                            'Người Theo Dõi'),
                                        _buildStat(
                                            profileController.following
                                                .toString(),
                                            'Đang Theo Dõi'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
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
                      Obx(
                        () => _buildTabContent(profileController.listFriends),
                      )
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
      height: MediaQuery.of(context).size.height -
          340, // Điều chỉnh chiều cao theo cần thiết
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
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Số lượng cột
        crossAxisSpacing: 8.0, // Khoảng cách giữa các cột
        mainAxisSpacing: 8.0, // Khoảng cách giữa các dòng
      ),
      itemCount: friendList.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildFriendItem(friendList[index]);
      },
    );
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

void _pickImage(BuildContext context, ImageSource source) async {
  XFile? pickedImage = await ImagePicker().pickImage(source: source);

  if (pickedImage != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DisplaySelectedImagePage(imagePath: pickedImage.path),
      ),
    );
  }
}

void _pickImageBackGroud(BuildContext context, ImageSource source, String Name,
    String Avatar) async {
  XFile? pickedImage = await ImagePicker().pickImage(source: source);

  if (pickedImage != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayBackGroudImagePage(
          imagePath: pickedImage.path,
          Avatar: Avatar,
          Name: Name,
        ),
      ),
    );
  }
}

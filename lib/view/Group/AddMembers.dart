import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/controller/Group/HomeGroupController.dart';

import '../../model/GroupModel.dart';
import '../../model/UsersEnity.dart';

class AddMembersGroup extends StatefulWidget {
  const AddMembersGroup({Key? key}) : super(key: key);

  @override
  State<AddMembersGroup> createState() => _AddMembersGroupState();
}

class User {
  final int id;
  final String name;
  final String avatar;
  bool check;

  User(this.id, this.name, this.avatar, this.check);
}

class _AddMembersGroupState extends State<AddMembersGroup> {
  final HomeGroupController homeGroupController = Get.put(HomeGroupController());


  final List<User> userss = [
    User(1,'Đỗ Duy Hào', 'assets/images/facebook.png', false),
    User(1,'Trần Bửu Quyến', 'assets/images/google.png', false),
    User(1,'Văn Bá Trung Thành', 'assets/images/backgourd.png', false),
    User(1,'Đỗ Duy Hào', 'assets/images/facebook.png', false),
  ];
  List<User> users =[];
  List<User> searchResults = [];

  void onSearch(String keyword) {
    searchResults.clear();
    if (keyword.isNotEmpty) {
      for (var user in users) {
        if (user.name.toLowerCase().contains(keyword.toLowerCase())) {
          searchResults.add(user);
        }
      }
    }
    setState(() {});
  }
  void _loadFriends(){
    homeGroupController.loadFriends;
  }
  Future<void> _mapUserMemberToUser() async {
    if (homeGroupController.users!= null) {
      homeGroupController.users!.forEach((element) {
        User user = User(element.id, element.firstName + " " + element.lastName,
            element.profilePicture, false);
        users.add(user);
      });
    }
  }
  @override
  void initState() {
    super.initState();
  _mapUserMemberToUser();

  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Color(0xFF8587F1),
                  title: Text('Thêm thành viên'),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          'Bạn có thể mời các bạn bè dưới đây: ',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Tìm kiếm người dùng',
                          ),
                          onChanged: (text) {
                            onSearch(text);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      bool isChecked = false; // Giá trị `isChecked` riêng lẻ cho mỗi phần tử

                      return Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(searchResults.isEmpty
                                  ? users[index].avatar
                                  : searchResults[index].avatar),
                            ),
                            title: Text(
                              searchResults.isEmpty
                                  ? users[index].name
                                  : searchResults[index].name,
                            ),
                            trailing: Checkbox(
                              value: searchResults.isEmpty
                                  ? users[index].check
                                  : searchResults[index].check,
                              onChanged: (bool? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    searchResults.isEmpty
                                        ? users[index].check = newValue
                                        : searchResults[index].check = newValue;
                                  });
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      );
                    },
                    childCount: searchResults.isEmpty
                        ? users.length
                        : searchResults.length,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          bottom: 5,
          right: 20,
          child: Container(
            child: ElevatedButton(
              onPressed: () {
                List<User> selectedUsers = users.where((user) => user.check).toList();
                homeGroupController.addSelectedMembers(context, selectedUsers);
                selectedUsers = [];
                users = [];
                Future.delayed(Duration(milliseconds: 100), () {
                  int count =0;
                  Navigator.of(context).popUntil((_) => count++ >= 1);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8587F1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(Icons.add),
                  ),
                  Text(
                    'Mời vào nhóm',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

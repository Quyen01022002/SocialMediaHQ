import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/controller/Group/HomeGroupController.dart';

class ListMemberGroup extends StatefulWidget {
  const ListMemberGroup({super.key});

  @override
  State<ListMemberGroup> createState() => _ListMemberGroupState();
}
class UserList {
  final int id;
  final String name;
  final String avatar;
  UserList(this.id, this.name, this.avatar);
}
class _ListMemberGroupState extends State<ListMemberGroup> {

  final HomeGroupController homeGroupController = Get.put(HomeGroupController());

  final List<UserList> userss = [
    UserList(1,'Đỗ Duy Hào', 'assets/images/facebook.png'),
    UserList(1,'Trần Bửu Quyến', 'assets/images/google.png'),
    UserList(1,'Văn Bá Trung Thành', 'assets/images/backgourd.png'),
    UserList(1,'Đỗ Duy Hào', 'assets/images/facebook.png'),
  ];
  List<UserList> users = [];
  List<UserList> searchResults = [];
  Future<void> _mapUserMemberToUser() async {
    if (homeGroupController.listUserMembers!= null) {
      homeGroupController.listUserMembers!.forEach((element) {
        UserList user = UserList(element.id, element.firstName + " " + element.lastName,
            element.profilePicture);
        users.add(user);
      });
    }
  }
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

  @override
  void initState() {
    super.initState();
   // homeGroupController.GetOneGroup(context, homeGroupController.group_id.value);
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
                  title: Text('Danh sách thành viên trong nhóm'),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // Container(
                      //   padding: EdgeInsets.only(top: 20, bottom: 20, left:20, right: 20),
                      //   child: Text(
                      //     'Wow! Hãy xem các phần tử có các gương mặt sáng mà bạn đã liệt kê vào đây ',
                      //     style: TextStyle(
                      //       fontSize: 18,
                      //     ),
                      //   ),
                      // ),
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
                    if (homeGroupController.isAdmin.value == true)
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

                            trailing: ElevatedButton(
                              onPressed: () {

                                _showConfirmationDialog(context,users[index].id);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF8587F1),
                              ),
                              child: Text('Xóa'),
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      );
                    else
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
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8587F1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Xong',
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
  void _showConfirmationDialog(BuildContext context, int idMember) {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận'),
          content: Text('Bạn có chắc chắn xóa thành viên này khỏi nhóm'),
          actions: [
            TextButton(
              onPressed: () {
                // Đóng hộp thoại và thực hiện tác vụ khi người dùng chọn Yes
                Navigator.of(context).pop();
                // Thực hiện tác vụ khi người dùng chọn Yes ở đây
              },
              child: Text('Không'),
            ),
            TextButton(
              onPressed: () {
                // Đóng hộp thoại khi người dùng chọn No
                homeGroupController.deleteMemberOutGroup(context, idMember);
                removeUser(idMember);
                Navigator.of(context).pop();
              },
              child: Text('Chắc chăn'),
            ),
          ],
        );
      },

    );
  }
  void removeUser(int id) {
    setState(() {
      users.removeWhere((user) => user.id == id);
    });
  }
}

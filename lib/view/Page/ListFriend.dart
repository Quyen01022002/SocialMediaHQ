import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/controller/PageHomeController.dart';

class ListFrScreen extends StatefulWidget {
  const ListFrScreen({super.key});

  @override
  State<ListFrScreen> createState() => _ListFrScreenState();
}
class UserListpage {
  final int id;
  final String name;
  final String avatar;
  UserListpage(this.id, this.name, this.avatar);
}
class _ListFrScreenState extends State<ListFrScreen> {


final PageHomeController pageHomeController = Get.put(PageHomeController());

  List<UserListpage> users = [];
  List<UserListpage> searchResults = [];
  Future<void> _mapUserMemberToUser() async {
    if (pageHomeController.listUserFr!= null) {
      pageHomeController.listUserFr!.forEach((element) {
        UserListpage user = UserListpage(element.user_id!, element.first_name! + " " + element.last_name!,
            element.avatarUrl!);
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
                  title: Text('Chuyển quyền admin trang cho bạn bè'),
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
                      if (true == true)
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
                                child: Text('Chuyển admin'),
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
      ],
    );
  }
  void _showConfirmationDialog(BuildContext context, int idMember) {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận'),
          content: Text('Giao quyền admin cho người này'),
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
              pageHomeController.updateAdmin(context, idMember);
                Future.delayed(Duration(milliseconds: 100), () {
                  int count =0;
                  Navigator.of(context).popUntil((_) => count++ >= 2);
                });
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

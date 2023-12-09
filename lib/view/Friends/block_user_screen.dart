import 'package:flutter/material.dart';

class BlockUserScreen extends StatefulWidget {
  const BlockUserScreen({super.key});

  @override
  State<BlockUserScreen> createState() => _BlockUserScreenState();
}

class User {
  final String name;
  final String avatar;
  User(this.name, this.avatar);
}
class _BlockUserScreenState extends State<BlockUserScreen> {
  final List<User> users = [
    User('Đỗ Duy Hào', 'assets/images/facebook.png'),
    User('Trần Bửu Quyến', 'assets/images/google.png'),
    User('Văn Bá Trung Thành', 'assets/images/backgourd.png'),
    User('Đỗ Duy Hào', 'assets/images/facebook.png'),
  ];

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
                  title: Text('Danh sách đen của bạn'),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20, left:20, right: 20),
                        child: Text(
                          'Wow! Hãy xem các phần tử có các gương mặt sáng mà bạn đã liệt kê vào đây ',
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
                              backgroundImage: AssetImage(searchResults.isEmpty
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
                                // Xử lý sự kiện khi nút được nhấn
                                _showConfirmationDialog(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF8587F1),
                              ),
                              child: Text('Bỏ chặn'),
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
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận'),
          content: Text('Bạn có chắc chắn bỏ chặn'),
          actions: [
            TextButton(
              onPressed: () {
                // Đóng hộp thoại và thực hiện tác vụ khi người dùng chọn Yes
                Navigator.of(context).pop();
                // Thực hiện tác vụ khi người dùng chọn Yes ở đây
              },
              child: Text('Đúng rồi, hết giận rồi'),
            ),
            TextButton(
              onPressed: () {
                // Đóng hộp thoại khi người dùng chọn No
                Navigator.of(context).pop();
              },
              child: Text('Không, tao giận dai lắm, phải chặn tiếp'),
            ),
          ],
        );
      },

    );
  }
}

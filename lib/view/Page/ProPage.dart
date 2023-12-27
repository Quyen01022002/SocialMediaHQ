import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/controller/PageHomeController.dart';
import 'package:socialmediahq/view/Page/ListFriend.dart';
import 'package:socialmediahq/view/Page/UpdatePage.dart';

import '../../component/Post/create_post_Group.dart';
import '../../model/PageLoad.dart';
import '../../model/PageModel.dart';
import 'DisplaySelectedImagePage.dart';

class ProPage extends StatefulWidget {
  const ProPage({super.key});

  @override
  State<ProPage> createState() => _ProPageState();
}

class _ProPageState extends State<ProPage> with SingleTickerProviderStateMixin {

  final PageHomeController pageHomeController = Get.put(PageHomeController());
  Stream<PageLoad>? pageLoadCurrent;
  PageLoad? pageLoad;
  late RxString curnetUser = "".obs;

  void initCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    curnetUser = (prefs.getString('Avatar') ??
        "https://inkythuatso.com/uploads/thumbnails/800/2023/03/10-anh-dai-dien-trang-inkythuatso-03-15-27-10.jpg")
        .obs;
    print(curnetUser);
  }

  @override
  void initState() {
    super.initState();
    initCurrentUser();
     _startTimer();
  }
  late Timer _timer;
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // Gọi hàm cần thiết ở đây
      pageLoadCurrent = pageHomeController.pageLoadCurrent;
      // Đây là Stream mà bạn cần theo dõi
      // Cập nhật danh sách nhóm khi Stream thay đổi
      pageLoadCurrent?.listen((PageLoad? currentGroup) {
        if (currentGroup != null) {
          setState(() {
            pageLoad = currentGroup;
          });
        }
      });
    });
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      //resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children:[
                Container(
                decoration: BoxDecoration(color: Colors.white),
                child: StreamBuilder<PageLoad>(
                  stream: pageLoadCurrent,
                  builder: (context, snapshot) {
                    if (snapshot.hasData){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 280,
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  _pickImage(context, ImageSource.gallery, pageHomeController.page_id.value);
                                },
                                child: Image.asset(
                                  "assets/images/backgroud_profile_page.png",
                                  fit: BoxFit.cover,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                ),
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 10,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            80)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ClipOval(
                                        child: GestureDetector(
                                          onTap: (){
                                            _pickImage(context, ImageSource.gallery, pageHomeController.page_id.value);
                                          },
                                          child:Image.network(
                                            snapshot.data!.pageModel!.Avatar.toString(),
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              // Xử lý khi có lỗi tải ảnh từ liên kết
                                              return
                                                Image.network(
                                                snapshot.data!.pageModel!.Avatar.toString(), // Thay đổi thành đường dẫn ảnh mặc định của bạn
                                                width: 150,
                                                height: 150,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),

                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          ),

                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 5, left: 25, right: 15, bottom: 0),
                          margin: EdgeInsets.only(bottom: 0),
                          child: Column(
                            children: [
                              Text(snapshot.data!.pageModel!.name.toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,)
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 20, left: 25, right: 18),
                          child: Text(
                            snapshot.data!.pageModel!.description.toString(),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 25, top: 10),
                          child: Row(

                            children: [
                              // Column(
                              //   children: [
                              //     Row(
                              //       children: [
                              //         Text(snapshot.data!.countLiked.toString(),
                              //           style: TextStyle(
                              //             fontWeight: FontWeight.bold,
                              //           ),),
                              //         Text(" Lượt thích"),
                              //       ],
                              //     ),
                              //     if (snapshot.data!.isLiked == true)
                              //     ElevatedButton(
                              //       onPressed: () {
                              //         // Xử lý khi nút 1 được nhấn
                              //       },
                              //       child: Text('Bỏ thích'),
                              //       style: ElevatedButton.styleFrom(
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(8.0),
                              //         ),
                              //         backgroundColor: Color(0xFF8587F1),
                              //       ),
                              //
                              //     ),
                              //     if (snapshot.data!.isLiked == false)
                              //       ElevatedButton(
                              //         onPressed: () {
                              //           // Xử lý khi nút 1 được nhấn
                              //         },
                              //         child: Text('Thích'),
                              //         style: ElevatedButton.styleFrom(
                              //           shape: RoundedRectangleBorder(
                              //             borderRadius: BorderRadius.circular(8.0),
                              //           ),
                              //           backgroundColor: Color(0xFF8587F1),
                              //         ),
                              //       ),
                              //   ],
                              // ),
                              // SizedBox(width: 20,),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(snapshot.data!.countFollowing.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      Text(" Lượt theo dõi")
                                    ],
                                  ),
                                  if (snapshot.data!.isFollowing == true)
                                  ElevatedButton(
                                    onPressed: () {
                                      // Xử lý khi nút 1 được nhấn
                                      pageHomeController.unfollowPage(context);
                                    },
                                    child: Text('Hủy theo dõi'),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      backgroundColor: Color(0xFF8587F1),
                                    ),
                                  ),
                                  if (snapshot.data!.isFollowing == false)
                                    ElevatedButton(
                                      onPressed: () {
                                        // Xử lý khi nút 1 được nhấn
                                        pageHomeController.followPage(context);
                                      },
                                      child: Text('Theo dõi'),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        backgroundColor: Color(0xFF8587F1),
                                      ),
                                    ),
                                ],
                              ),

                            ],
                          ),
                        ),
                        Card(
                          elevation: 3,
                          margin: EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(curnetUser.value),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: TextFormField(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.bottomToTop,
                                              child: CreatePostGroup(
                                                statepost: false,
                                                idGroup:
                                                pageHomeController.page_id.value,
                                              ),
                                            ),
                                          );
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Bạn nghĩ gì?",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 15, // Chiều cao của thanh ngang
                          width: 500, // Độ dày của thanh ngang
                          color: Color(0xC0C0C0C0),
                        ),
                      ],
                    );}
                    else
                      {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 280,
                              child: Stack(
                                children: [
                                  Image.asset(
                                    "assets/images/backgroud_profile_page.png",
                                    fit: BoxFit.cover,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      left: 10,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                80)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: ClipOval(
                                            child: Image.asset(
                                              "assets/images/backgourd.png",
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              ),

                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 5, left: 15, right: 15, bottom: 0),
                              margin: EdgeInsets.only(bottom: 0),
                              child: Column(
                                children: [
                                  Text("Loading....",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,)
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 20, left: 18, right: 18),
                              child: Text(
                                "Loading.....",
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              height: 15, // Chiều cao của thanh ngang
                              width: 500, // Độ dày của thanh ngang
                              color: Color(0xC0C0C0C0),
                            ),
                          ],
                        );
                      }

                  }),

              ),
                if (pageHomeController.isAdmin.value == true)
                Positioned(
                  top: 200,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      // Xử lý khi icon được nhấn
                      showPopupMenu(context);
                      // Hiển thị các tùy chọn hoặc thực hiện hành động cần thiết
                    },
                    child: Icon(
                      FontAwesomeIcons.bars, // Sử dụng icon ba gạch của Flutter
                      size: 30, // Điều chỉnh kích thước nếu cần
                      color: Colors.white, // Điều chỉnh màu sắc nếu cần
                    ),
                  ),
                ),]
            ),
          ),
          SliverFillRemaining(
            child: Text("Quyến"),
          ),


        ],
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
  Future<void> showPopupMenu(BuildContext context) async {
    if (await true == true) {
      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(100, 200, 0, 0),
        items: <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'update',
            child: Text('Cập nhật'),
          ),
          const PopupMenuItem<String>(
            value: 'changeAdmin',
            child: Text('Giao quyền admin'),
          ),
          const PopupMenuItem<String>(
            value: 'delete',
            child: Text('Xóa trang'),
          ),
        ],
      ).then((value) {
        // Xử lý khi chọn một tùy chọn
        if (value == 'update') {
          // Thực hiện hành động update
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdatePage()),
          );
        } else if (value == 'delete') {
          // Thực hiện hành động delete
          showDeleteOption(context);
        }
        else if (value == 'changeAdmin') {
          // Thực hiện hành động delete
          pageHomeController.loadFriends(context);

        }
      });
    }
    else
    {
      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(100, kToolbarHeight, 0, 0),
        items: <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'outgroup',
            child: Text('Rời nhóm'),
          ),
        ],
      ).then((value) {
        // Xử lý khi chọn một tùy chọn
        if (value == 'outgroup') {
          // Thực hiện hành động outgroup
          showOutGroupOption(context);
        }
      });
    }
  }
  void showDeleteOption(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Xác nhận"),
          content: Text("Bạn có chắc chắn muốn xóa trang này?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: Text("Không"),
            ),
            TextButton(
              onPressed: () {
  pageHomeController.DeletePage(context);
              },
              child: Text("Có"),
            ),
          ],
        );
      },
    );
  }
  void showOutGroupOption(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Xác nhận"),
          content: Text("Bạn muốn rời khỏi nhóm này?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại
              },
              child: Text("Không"),
            ),
            TextButton(
              onPressed: () {

              },
              child: Text("Có"),
            ),
          ],
        );
      },
    );
  }

}
void _pickImage(BuildContext context, ImageSource source,int groupId) async {
  XFile? pickedImage = await ImagePicker().pickImage(source: source);

  if (pickedImage != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DisplaySelectedPage(imagePath: pickedImage.path,pageId: groupId),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/component/Post/update_post.dart';
import 'package:socialmediahq/controller/HomeController.dart';
import 'package:socialmediahq/model/PostModel.dart';
import 'package:socialmediahq/view/Comments/CommentHome.dart';
import 'package:intl/intl.dart';
import 'package:socialmediahq/view/Settings/ProfileScreenOther.dart';
import '../../view/Comments/ContentComments.dart';
import '../../view/Home/ViewPostScreen.dart';


class Home_Post extends StatefulWidget {
  final PostModel postModel;

  const Home_Post({Key? key, required this.postModel}) : super(key: key);

  @override
  State<Home_Post> createState() => _Home_PostState();
}

class _Home_PostState extends State<Home_Post> {
  late bool statelike=false;
  late int contlike=0;
  late RxInt curnetUser=0.obs;
  late String formattedTime = '';
  HomeController home_postcontroller = new HomeController();


  @override
  void initState() {
    super.initState();
    statelike = widget.postModel.user_liked;
    formattedTime = formatTimeDifference(widget.postModel.timeStamp);
    contlike=widget.postModel.like_count;
    initCurrentUser();
  }

  void initCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    curnetUser = (prefs.getInt('id') ?? 0).obs;
  }
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          statelike?contlike=contlike-1:contlike=contlike+1;
          statelike = !statelike;
        });
        home_postcontroller.postid.value = widget.postModel.id;
        home_postcontroller.Like();
        print("Like");
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: Colors.white,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: ProfileScreenOther(id: widget.postModel.createBy.id,),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0,10,8,8),
                        child: ClipOval(
                            child: Image.network(
                         widget.postModel.createBy.profilePicture,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.postModel.createBy.firstName+" "+widget.postModel.createBy.lastName,
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                          ),
                          Text(
                            formattedTime,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFCECECE),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      curnetUser==widget.postModel.createBy.id?
                      _showBottomSheet(context,widget.postModel,home_postcontroller):_showBottomSheetReport(context,widget.postModel,home_postcontroller);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Icon(Icons.more_horiz),
                    ),
                  ),
                ],
              ),
            ),
            widget.postModel.listAnh.isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child:ExpandableTextWidget(
                      text:
                      widget.postModel.contentPost.toString(),
                      maxLines: 3,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: ViewPostScreen(
                                postModel: widget.postModel,
                              ),
                            ),
                          );
                        },
                        child:Container(
                        height: 500,
                        decoration: BoxDecoration(color: Colors.grey),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.postModel.listAnh.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.network(
                                widget.postModel.listAnh[index].link_picture,
                                fit: BoxFit.cover, // Để ảnh nằm đúng trong phạm vi của nó
                                width: MediaQuery.of(context).size.width, // Đảm bảo chiều rộng hình ảnh bằng chiều rộng của màn hình
                                height: 500, // Chiều cao của Container
                              ),
                            );
                          },
                        ),
                      ),
                      )


                    ],
                  ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0,16,0,10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  statelike?contlike=contlike-1:contlike=contlike+1;
                                  statelike = !statelike;
                                });
                                home_postcontroller.postid.value =
                                    widget.postModel.id;
                                home_postcontroller.Like();
                                print("Like");
                              },
                              child: statelike == false
                                  ? Icon(Icons.favorite_border,
                                  color:Colors.black,)
                                  : Icon(Icons.favorite, color: Colors.red)),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.bottomToTop,
                              child: CommentHome(
                                postEntity: widget.postModel,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.mode_comment_outlined,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(
                      Icons.turned_in_not_outlined,
                      color: Colors.black,
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(contlike.toString()+" lượt thích",style: TextStyle(fontWeight: FontWeight.w500),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16,0,10,20),
              child: ExpandableTextWidget(
                text: widget.postModel.contentPost.toString(),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
  String formatTimeDifference(String timeStamp) {
    DateTime dateTime = DateTime.parse(timeStamp);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inDays > 30) {
      return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inHours > 0) {
      if (difference.inMinutes > 0) {
        return '${difference.inHours} giờ';
      } else {
        return '${difference.inHours} giờ trước';
      }
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} phút trước';
    } else {
      return "Bây giờ";
    }
  }
}
void _showBottomSheet(BuildContext context,PostModel post,HomeController home_postcontroller) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext builderContext) {
      return Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.update),
              title: Text('Chỉnh sửa bái viết'),
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: UpdatePost(statepost: false,
                      postModel: post,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Xóa bài viết'),
              onTap: () {
                _showDeleteConfirmationDialog(context,post,home_postcontroller);
              },
            ),
            // Add more items as needed
          ],
        ),
      );
    },
  );
}
void _showBottomSheetReport(BuildContext context,PostModel post,HomeController home_postcontroller) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext builderContext) {
      return Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.update),
              title: Text('Báo cáo bái viết'),
              onTap: () {
                home_postcontroller.postid.value =
                    post.id;
                home_postcontroller.ReportPost();
              },
            ),
            // Add more items as needed
          ],
        ),
      );
    },
  );
}
void _showDeleteConfirmationDialog(BuildContext context, PostModel post,HomeController home_postcontroller) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('Xác nhận xóa bài viết'),
        content: Text('Bạn có chắc chắn muốn xóa bài viết này không?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Đóng hộp thoại
            },
            child: Text(
              'Hủy',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              home_postcontroller.postid.value =
                  post.id;
              home_postcontroller.DeletePost();
              Navigator.of(dialogContext).pop(); // Đóng hộp thoại
            },
            child: Text(
              'Xóa',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}


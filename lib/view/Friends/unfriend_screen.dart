import 'package:flutter/material.dart';

class UnfriendPage extends StatefulWidget {
  const UnfriendPage({super.key});

  @override
  State<UnfriendPage> createState() => _UnfriendPageState();
}

class _UnfriendPageState extends State<UnfriendPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Unfriend Page'), // Tiêu đề của màn hình
        ),

        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 40, left: 35),
                height: 200,
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(80)),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/facebook.png",
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Text('Đỗ Duy Hào', style: TextStyle(
                            fontSize: 20,
                          ),),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60, bottom: 20, left: 10, right: 10),
                        child: Image.asset(
                          "assets/images/unfriend.png",
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),

                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(80)),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/google.png",
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Text('Trần Bửu Quyến', style: TextStyle(
                            fontSize: 20,

                          ),),
                        ],

                      ),
                    ),
                  ],
                ),
              ),
              Column(

                children: [
                  Container(
                    padding: EdgeInsets.only(left: 40, right: 20, top: 10),
                    child: Text('Nếu bạn xóa kết bạn, bạn sẽ không thể tương tác với Trần Bửu Quyến qua:\n\t- Tin nhắn\n\t- Tin tức\n\t- Bài viết',
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.5,

                        ),

                    ),
                  ),


                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    child: Text(
                      'Bạn chắc chắn xóa kết bạn với người này?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),

                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      backgroundColor: Color(0xFF8587F1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(125, 18, 125, 18),
                      child: Text('Xóa kết bạn'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

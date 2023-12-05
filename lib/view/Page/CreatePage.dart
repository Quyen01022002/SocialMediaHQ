//CHÚ Ý
// TRANG NÀY ĐANG CODE










import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socialmediahq/view/Page/CreatePage2.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _startAutoTabSwitch();
  }

  void _startAutoTabSwitch() {
    const switchInterval = Duration(seconds: 5); // Đặt khoảng thời gian tự chuyển tab (5 giây trong ví dụ này)
    Timer.periodic(switchInterval, (timer) {
      if (_tabController.index < _tabController.length - 1) {
        _tabController.animateTo(_tabController.index + 1);
      } else {
        _tabController.animateTo(0);
      }
    });
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Tạo trang',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              backgroundColor: Color(0xFF8587F1),
            ),
            body: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      // Tab 1 content
                      _buildTab1(),
                      _buildTab2(),
                      _buildTab3(),
                    ],
                  ),




                )






              ],






            ),
           /* bottomNavigationBar: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_tabController.index > 0) {
                      _tabController.animateTo(_tabController.index - 1);
                    }
                  },
                  child: Text('Tab trước'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_tabController.index < _tabController.length - 1) {
                      _tabController.animateTo(_tabController.index + 1);
                    }
                  },
                  child: Text('Tab tiếp theo'),
                ),
              ],
            ),*/

          ),


        ),

        Positioned(
          left: 20,
          bottom: 5,
          right: 20,
          child: Column(
            children: [
              Container(
                height: 50,
                color: Colors.black,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreatePage2()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8587F1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        'Bắt đầu tạo trang',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text('Đọc thêm vài chính sách cơ bản',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black


                ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildTab1() {
    return Container(
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.cover,
                child: Image.asset("assets/images/khongbaiviet.png")
            ),

          )  ,
          Container(
            child: Text(
              'Tạo trang để có thể trải nghiệm gì đó hơn nữa'
            ),

          ),
          /*Container(
            child: ElevatedButton(
              onPressed: () {
                _tabController.animateTo(_tabController.index + 1);

              },
              child: Text('Chuyển đến Tab 2'),
            ),
          ),*/

        ],

      ),

    );
  }
  Widget _buildTab2() {
    return Container(
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset("assets/images/hot_news_page.png")
            ),

          )  ,
          Container(
            child: Text(
                'Tạo trang để có thể trải nghiệm gì đó hơn nữa'
            ),

          ),
          /*Container(
            child: ElevatedButton(
              onPressed: () {
                _tabController.animateTo(_tabController.index + 1);

              },
              child: Text('Chuyển đến Tab 2'),
            ),
          ),*/

        ],

      ),

    );
  }
  Widget _buildTab3() {
    return Container(
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset("assets/images/forum_page.jpg")
            ),

          )  ,
          Container(
            child: Text(
                'Tạo trang để có thể trải nghiệm gì đó hơn nữa'
            ),

          ),
          /*Container(
            child: ElevatedButton(
              onPressed: () {
                _tabController.animateTo(_tabController.index + 1);

              },
              child: Text('Chuyển đến Tab 2'),
            ),
          ),*/

        ],

      ),

    );
  }
}

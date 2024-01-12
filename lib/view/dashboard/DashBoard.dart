import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:socialmediahq/component/Post/create_post.dart';
import 'package:socialmediahq/controller/DashBoardController.dart';
import 'package:socialmediahq/view/Friends/friend_sreen.dart';
import 'package:socialmediahq/view/Home/home_screen.dart';
import 'package:socialmediahq/view/Notification/notification_screen.dart';
import 'package:socialmediahq/view/Settings/setting_screen.dart';
import 'package:badges/badges.dart' as badges;

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final NoticationsController myController = Get.put(NoticationsController());
  int currentTab = 0;
  final List<Widget> screens = [
    HomeScreen(),
    WatchScreen(),
    NotificationScreen(),
    SettingScreen()
  ];
  final PageStorageBucket buket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    myController.loadNoticationsIsRead();
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = screens[currentTab];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageStorage(
        child: currentScreen,
        bucket: buket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.bottomToTop,
              child: CreatePost(
                statepost: false,
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentTab = 0;
                          currentScreen = HomeScreen();
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.dashboard,
                            color: currentTab == 0 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            "Home",
                            style: TextStyle(
                              color:
                                  currentTab == 0 ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentTab = 1;
                          currentScreen = screens[currentTab];
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people,
                            color: currentTab == 1 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            "Friends",
                            style: TextStyle(
                              color:
                                  currentTab == 1 ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentTab = 2;
                          currentScreen = screens[currentTab];
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          myController.listNoticaiotnsIsRead.length <= 0
                              ? badges.Badge(
                                  badgeContent: Text(
                                    myController.listNoticaiotnsIsRead.length <=
                                            99
                                        ? myController
                                            .listNoticaiotnsIsRead.length
                                            .toString()
                                        : '99+',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 8),
                                  ),
                                  child: Icon(
                                    Icons.notifications,
                                    color: currentTab == 2
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                )
                              : Icon(
                                  Icons.notifications,
                                  color: currentTab == 2
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                          Text(
                            "Notification",
                            style: TextStyle(
                              fontSize: 12,
                              color:
                                  currentTab == 2 ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentTab = 3;
                          currentScreen = screens[currentTab];
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.menu,
                            color: currentTab == 3 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            "Profiles",
                            style: TextStyle(
                              color:
                                  currentTab == 3 ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

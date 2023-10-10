import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/view/authen/getstarted_screen.dart';

import '../dashboard/DashBoard.dart';

class SplashScreen extends StatefulWidget {
  final bool animated;

  const SplashScreen({Key? key, required this.animated}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool animated;

  @override
  void initState() {
    super.initState();
    animated = widget.animated;
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/backgourd.png',
              width: 400,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.center,
              child: Center(
                child: Container(
                  height: animated ? 400 : 700,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/backitem1.png',
                      ),
                      Image.asset(
                        'assets/images/backitem2.png',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context)
                  .size
                  .width, // Lấy chiều rộng của màn hình
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 600),
                    top: animated ? 220 : 0,
                    left: animated ? 110 : -80,
                    child: Container(
                        width: 170,
                        height: 170,
                        child: Image.asset('assets/images/item1.png')),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 600),
                    top: animated ? 320 : 420,
                    left: animated ? 20 : -100,
                    child: Container(
                        width: 170,
                        height: 170,
                        child: Image.asset('assets/images/item2.png')),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 600),
                    top: animated ? 320 : 250,
                    right: animated ? 20 : -80,
                    child: Container(
                        width: 170,
                        height: 170,
                        child: Image.asset('assets/images/item3.png')),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 600),
                    top: animated ? 420 : 610,
                    right: animated ? 110 : -100,
                    child: Container(
                        width: 170,
                        height: 170,
                        child: Image.asset('assets/images/item4.png')),
                  ),
                ],
              ),
            ),
            AnimatedPositioned(
                duration: const Duration(milliseconds: 800),
                top: animated ? 150 : 0,
                left: animated ? 120 : 0,
                child: Text(
                  "Q&H Social",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Future<void> startAnimation() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      animated = true;
    });
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    isLoggedIn
        ? (
        Future.delayed(Duration(milliseconds: 600), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashBoard()),
            );
          }))
        : (
            Future.delayed(Duration(milliseconds: 600)),
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: Getstarted_Screen(animated: false),
              ),
            ),
          );
  }
}

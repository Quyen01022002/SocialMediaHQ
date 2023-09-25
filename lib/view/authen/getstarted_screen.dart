import 'package:flutter/material.dart';
import 'package:socialmediahq/view/authen/Login_screen.dart';

import 'dart:async';

import '../dashboard/DashBoard.dart';
class Getstarted_Screen extends StatefulWidget {
  final bool animated;

  const Getstarted_Screen({Key? key, required this.animated}) : super(key: key);

  @override
  State<Getstarted_Screen> createState() => _Getstarted_ScreenState();
}

class _Getstarted_ScreenState extends State<Getstarted_Screen> {
  late bool animated=false;



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
                  height: 400,
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
                    top:animated ? -30:220,
                    left: animated ? 390:110 ,
                    child: Container(
                        width: 170,
                        height: 170,
                        child: Image.asset('assets/images/item1.png')),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 600),
                    top:animated ? 80:320,
                    left:animated? -180:20,
                    child: Container(
                        width: 170,
                        height: 170,
                        child: Image.asset('assets/images/item2.png')),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 600),
                    top: animated? 480:320,
                    right:animated? -180:20,
                    child: Container(
                        width: 170,
                        height: 170,
                        child: Image.asset('assets/images/item3.png')),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 600),
                    top: animated?680:420,
                    right:animated? 410:110,
                    child: Container(
                        width: 170,
                        height: 170,
                        child: Image.asset('assets/images/item4.png')),
                  ),
                ],
              ),
            ),
            AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                top: animated? -300:80,
                left: animated?120:120,
                child: Text(
                  "Q&H Social",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            AnimatedPositioned(
                duration: const Duration(milliseconds: 600),
                bottom: animated? -20:160,
                left: animated?100:100,
                child: Text(
                  "SHARE - INSPIRE - CONNECT",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,

                  ),
                )),
            Positioned(
              bottom: 50,
              left: 10,
              child:ElevatedButton(
                onPressed: () {
                  changeAnimationState();


                  Future.delayed(Duration(milliseconds: 200), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Loginscreen(animated: false,)),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    // Để tạo nút tròn
                  ),
                  backgroundColor: Color(0xFF8587F1),
                ),
                child:  Padding(
                  padding:  const EdgeInsets.fromLTRB(125, 18, 125, 18),
                  child: Text('GET STARTED'),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
  void changeAnimationState() {
    setState(() {
      animated = !animated;
    });
  }
}

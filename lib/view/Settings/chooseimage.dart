import 'package:flutter/material.dart';

class ChooseImage extends StatefulWidget {
  const ChooseImage({Key? key}) : super(key: key);

  @override
  State<ChooseImage> createState() => _ChooseImageState();
}

class _ChooseImageState extends State<ChooseImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Phần còn lại của màn hình
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('your_background_image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Phần dưới cùng màu trong suốt
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 300,
            child: Container(
              color: Colors.transparent, // Màu đen trong suốt
              // Các nội dung trong phần dưới cùng
            ),
          ),
        ],
      ),
    );
  }
}

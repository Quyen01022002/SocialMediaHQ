import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../controller/UpdateUser.dart';

class DisplayBackGroudGroup extends StatefulWidget {
  final String imagePath;
  DisplayBackGroudGroup({required this.imagePath});

  @override
  _DisplaySelectedImagePageState createState() =>
      _DisplaySelectedImagePageState();
}

class _DisplaySelectedImagePageState extends State<DisplayBackGroudGroup> {
  final UpdateUserController myController = Get.put(UpdateUserController());
  String? caption;
  late bool statepost;

  Future<void> _uploadImages() async {
    var url =
        Uri.parse('https://api.cloudinary.com/v1_1/dq21kejpj/image/upload');

    var request = http.MultipartRequest('POST', url);
    request.fields['upload_preset'] = 'q8pgyal8';
    request.files.add(
      await http.MultipartFile.fromPath('file', widget.imagePath),
    );

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        final imageUrl = jsonMap['url'];

        myController.imagePath.value = imageUrl;
        print('Image URL: $imageUrl');
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    statepost = false;
  }

  @override
  Widget build(BuildContext context) {
    return statepost == false
        ? Scaffold(
            appBar: AppBar(
              title: Text('Ảnh đã chọn'),
              actions: [
                IconButton(
                  icon: Icon(Icons.done),
                  onPressed: () async {
                    setState(() {
                      statepost = true;
                    });
                    await _uploadImages();
                    myController.UpdateBack(context);
                    Navigator.pop(
                      context,
                      {
                        'imagePath': widget.imagePath,
                      },
                    );
                  },
                ),
              ],
            ),
            body: Container(
              height: 300,
              child: Stack(
                children: [
                  Image.file(
                    File(widget.imagePath),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 220,
                  ),
                ],
              ),
            ),
          )
        : Center(
            child: SpinKitFoldingCube(
              color: Colors.blue,
              size: 50.0,
            ),
          );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.addOval(Rect.fromCircle(
        center: size.center(Offset.zero), radius: size.width / 2));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

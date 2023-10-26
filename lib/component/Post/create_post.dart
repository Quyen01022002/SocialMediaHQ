import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:socialmediahq/controller/CreatePost.dart';



class CreatePost extends StatefulWidget {
   final bool statepost;
  const CreatePost({Key? key,required this.statepost}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

  XFile? _image;
  late bool statepost;
  CreatePostController postController = new CreatePostController();
  @override
  void initState() {
    super.initState();
    statepost = widget.statepost;
  }

  Future<void> _getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = XFile(image!.path);
    });
  }

  Future<void> _uploadImage() async {
    var url = Uri.parse('https://api.cloudinary.com/v1_1/dq21kejpj/image/upload');

    var request = http.MultipartRequest('POST', url);
    request.fields['upload_preset'] = 'q8pgyal8';
    request.files.add(
      await http.MultipartFile.fromPath('file', _image!.path),
    );

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = String.fromCharCodes(responseData);
        final jsonMap = jsonDecode(responseString);
        final imageUrl = jsonMap['url'];
        postController.imagePath.value = imageUrl;
        print('Image URL: $imageUrl');
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }


  Future<void> _getImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = XFile(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusNode _focusNode = FocusNode();
    return statepost==false?Scaffold(
      body: GestureDetector(
        onVerticalDragEnd: (onVerticalDragEnd) async {
          Navigator.of(context).pop();
        },
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [

                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Colors.black, // You can specify the color here
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 26.0),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      Text(
                        "Post",
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.none,
                            fontSize: 23),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/backgourd.png",
                            fit: BoxFit.cover,
                            width: 40,
                            height: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _getImageFromCamera,
                      child: Container(
                        margin: EdgeInsets.all(16.0),
                        // Khoảng cách từ mép màn hình
                        padding: EdgeInsets.all(16.0),
                        // Khoảng cách bên trong TextField
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0), // Bo góc
                          border: Border.all(
                            color: Colors.grey, // Màu viền
                            width: 1.0, // Độ dày viền
                          ),
                        ),
                        child: Icon(
                          Icons.videocam_outlined,
                          size: 30,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _getImageFromGallery,
                      child: Container(
                        margin: EdgeInsets.all(4.0),
                        padding: EdgeInsets.all(16.0),
                        // Khoảng cách bên trong TextField
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0), // Bo góc
                          border: Border.all(
                            color: Colors.grey, // Màu viền
                            width: 1.0, // Độ dày viền
                          ),
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 30,
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          print("Đăng");
                          setState(() {
                            statepost=true;
                          });
                          postController.contentpost.value =
                              postController.textControllerContent.text;
                          await _uploadImage();
                          postController.createpost(context);
                        },
                        child: Text("Đăng"))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  margin: EdgeInsets.all(16.0),
                  // Khoảng cách từ mép màn hình
                  padding: EdgeInsets.all(16.0),
                  // Khoảng cách bên trong TextField
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0), // Bo góc
                    border: Border.all(
                      color: Colors.grey, // Màu viền
                      width: 1.0, // Độ dày viền
                    ),
                  ),
                  child: TextField(
                    focusNode: _focusNode,
                    autofocus: false,
                    controller: postController.textControllerContent,
                    maxLines: 5,
                    // Số dòng tối đa
                    decoration: InputDecoration(
                      hintText: "Bạn đang nghĩ gì?", // Text mặc định
                      border: InputBorder.none, // Ẩn viền của TextField
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (_image != null)
                  Image.file(
                    File(_image!.path),
                    height: 300,
                  ),
              ],
            ),
          ),
        ),
      ),
    ):Center(
      child: SpinKitFoldingCube(
        color: Colors.blue,
        size: 50.0,
      ),
    );
  }
}

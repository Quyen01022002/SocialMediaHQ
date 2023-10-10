import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:socialmediahq/controller/CreatePost.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  XFile? _image;
  CreatePostController postController=new CreatePostController();

  Future<void> _getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = XFile(image!.path);
    });
  }
  Future _uploadImage() async {
    final storage = FirebaseStorage.instance;
    final reference = storage.ref().child('images/${DateTime.now()}.jpg');
    final task = await reference.putFile(File(_image!.path));
    final imageUrl = await task.ref.getDownloadURL();

    setState(() {
      postController.imagePath.value = imageUrl;
    });
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
    return Scaffold(
      body: GestureDetector(
        onDoubleTap: () {
          print("Đăng");
          postController.contentpost.value=postController.textControllerContent.text;
          _uploadImage();
          if (_image != null)
             {postController.imagePath.value=_image!.path;}
          postController.createpost(context);
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
                    maxLines: 5, // Số dòng tối đa
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
                  Image.file(File(_image!.path),height: 300,),
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

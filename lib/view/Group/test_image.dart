import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';


class TestImage extends StatefulWidget {
  const TestImage({Key? key}) : super(key: key);

  @override
  State<TestImage> createState() => _TestImageState();
}

class _TestImageState extends State<TestImage> {
  File? _selectedImage;
  double height = 200; // Độ cao bạn muốn
  double width = 200; // Độ rộng bạn muốn

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Use the picked file directly or display it using PhotoView
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (_selectedImage != null)
            Container(
              width: 200,
              height: 200,
              child: PhotoView(
                imageProvider: FileImage(_selectedImage!),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
                initialScale: PhotoViewComputedScale.covered,
                basePosition: Alignment.center,
                backgroundDecoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Chọn ảnh'),
          ),
        ],
      ),
    );
  }
/*
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (_selectedImage != null)
            ClipRect(
              child: Image.file(
                _selectedImage!,
                height: height,
                width: width,
                fit: BoxFit.cover,
              ),
            ),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Chọn ảnh'),
          ),
        ],
      ),
    );
  }*/
}

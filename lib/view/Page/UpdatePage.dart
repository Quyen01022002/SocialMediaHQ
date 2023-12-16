import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialmediahq/controller/PageHomeController.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final PageHomeController pageHomeController = Get.put(PageHomeController());


  @override
  void initState() {
    super.initState();
    pageHomeController.getInfoPageToUpdate(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Chỉnh sửa thông tin trang',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              backgroundColor: Color(0xFF8587F1),
            ),
            body: SingleChildScrollView(
              child: Container(


                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Đổi tên trang',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: pageHomeController.textControllerNamePageUpdate,
                        decoration: const InputDecoration(
                          labelText: 'Tên trang',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color(0xFFF3F5F7),
                          hintStyle: TextStyle(
                            color: Colors.grey, // Đặt màu cho hint text
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Text('Mô tả về nhóm',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.only(left: 0, right: 0, top: 8),
                        height: 200.0, // Điều chỉnh chiều cao của TextField
                        width: 320.0, // Điều chỉnh độ rộng của TextField
                        child: TextField(
                          controller: pageHomeController.textControllerDescPageUpdate,
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.top,
                          style: TextStyle(
                            fontSize: 16,

                          ),
                          maxLines: null,
                          decoration: const InputDecoration(
                            labelText: 'Mô tả',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xFFF3F5F7),
                            hintStyle: TextStyle(
                              color: Colors.grey, // Đặt màu cho hint text
                            ),
                          ),
                        ),
                      ),
                      // if (_selectedImage != null)
                      //   Image.file(
                      //     _selectedImage!,
                      //     width: 200,
                      //     height: 200,
                      //   ),
                      // ElevatedButton(
                      //   onPressed: _pickImage,
                      //   child: Text('Chọn ảnh'),
                      // ),

                      Container(
                        padding: EdgeInsets.only(top: 100),
                        child: ElevatedButton(
                          onPressed: () {
                            pageHomeController.UpdatePage(context);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF8587F1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text(
                                'Lưu thông tin chỉnh sửa',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ),
            ),

          ),


        ),

        //HomeHeader(),
      ],
    );
  }

}

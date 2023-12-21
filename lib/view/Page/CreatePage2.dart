import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/view/Page/ProPage.dart';

import '../../controller/PageHomeController.dart';
import 'ProfilePage.dart';


class CreatePage2 extends StatefulWidget {
  const CreatePage2({super.key});

  @override
  State<CreatePage2> createState() => _CreatePage2State();
}

class _CreatePage2State extends State<CreatePage2> {
  final PageHomeController pageHomeController = Get.put(PageHomeController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Đặt tên trang',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              backgroundColor: Color(0xFF8587F1),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(


                    decoration: BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hãy bắt đầu với việc đặt tên cho trang của mình'
                              ,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                        TextField(
                              controller: pageHomeController.textControllerNamePage,
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
                              controller: pageHomeController.textControllerDescriptionPage,
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


                          const SizedBox(height: 100),
                          Container(
                            //height: 10,
                            padding: EdgeInsets.only(top: 50),
                            child: ElevatedButton(
                              onPressed: () {
                                pageHomeController.CreatePage(context);
                                Future.delayed(Duration(milliseconds: 300), () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ProPage()),
                                  );
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF8587F1),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Text(
                                    'Tạo trang',
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
                ],
              ),
            ),

          ),


        ),
        //HomeHeader(),
      ],
    );
  }
}

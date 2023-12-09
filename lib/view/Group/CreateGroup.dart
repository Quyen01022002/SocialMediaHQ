
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/controller/Group/CreateGroupController.dart';
import 'package:socialmediahq/view/Group/HomeGroup.dart';

import '../../component/Home_Header.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final GroupController myController = Get.put(GroupController());




  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Tạo nhóm',
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
                      Text('Hãy đặt một cái tên nhóm thật là ngầu nào!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: myController.textControllerNameGroup,
                        decoration: const InputDecoration(
                          labelText: 'Tên nhóm',
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
                      Text('Mô tả sự tuyệt vời về nhóm của bạn để thu hút cộng đồng nào!',
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
                          controller: myController.textControllerMota,
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

                      Container(
                        padding: EdgeInsets.only(top: 100),
                        child: ElevatedButton(
                          onPressed: () {
                            myController.desc.value = myController.textControllerMota.text;
                            myController.nameGroup.value= myController.textControllerNameGroup.text;
                            myController.CreateGroup(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF8587F1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Text(
                                'Tạo nhóm',
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

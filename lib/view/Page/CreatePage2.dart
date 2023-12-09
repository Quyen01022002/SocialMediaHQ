import 'package:flutter/material.dart';

class CreatePage2 extends StatefulWidget {
  const CreatePage2({super.key});

  @override
  State<CreatePage2> createState() => _CreatePage2State();
}

class _CreatePage2State extends State<CreatePage2> {


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


                          const SizedBox(height: 300),
                          Container(
                            //height: 10,
                            padding: EdgeInsets.only(top: 100),
                            child: ElevatedButton(
                              onPressed: () {
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

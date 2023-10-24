//CHÚ Ý
// TRANG NÀY ĐANG CODE










import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
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

//CHÚ Ý
// TRANG NÀY LÀ TRANG NHÁP

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'DisplaySelectedImagePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MyCustomScrollView(),

      ),
    );
  }
}
class MyCustomScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Row(
              children: <Widget>[

                ClipOval(
                  child: Image.asset(
                    'assets/images/backgourd.png',
                    width: 80.0, // Điều chỉnh kích thước của avatar theo nhu cầu của bạn
                    height: 80.0,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 8),

                Text('Đây là trang duy nhất của Ứng dụng MXH QH',
                  overflow: TextOverflow.ellipsis,
                maxLines: 1,),
              ],
            ),

            background: GestureDetector(

              child: Image.asset(
                'assets/images/backgroud_profile_page.png', // Đặt đường dẫn hình ảnh của bạn ở đây
                fit: BoxFit.cover,
              ),
            ),

            titlePadding: EdgeInsets.only(left: 20, bottom: 20),

          ),

        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return ListTile(
                title: Text('Item $index'),
              );
            },
            childCount: 50, // Thay đổi số lượng phần tử theo nhu cầu của bạn
          ),
        ),
        
        
        

      ],
    );
  }
}
void _pickImage(BuildContext context, ImageSource source,int groupId) async {
  XFile? pickedImage = await ImagePicker().pickImage(source: source);

  if (pickedImage != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DisplaySelectedPage(imagePath: pickedImage.path,pageId: groupId),
      ),
    );
  }
}
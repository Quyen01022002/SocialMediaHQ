import 'package:flutter/material.dart';
import 'package:socialmediahq/component/Item_Commemt.dart';


class ViewPostScreen extends StatefulWidget {
  const ViewPostScreen({Key? key}) : super(key: key);

  @override
  State<ViewPostScreen> createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16,0,16,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.favorite_border),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.add_circle_outline),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.share),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipOval(
                                child: Image.asset(
                                  "assets/images/backgourd.png",
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Text("Trần Bửu Quyến",style: TextStyle(fontSize: 16,decoration: TextDecoration.none,),),
                        ],

                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text("1 giờ",style: TextStyle(fontSize: 16,color: Color(0xFFCECECE),),),
                      ),
                    ],
                  ),
                  Image.asset("assets/images/post1.png",),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(26,8,26,8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.add_circle_outline,color: Color(0xFF5252C7),),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),

                                    child: Text("21",style: TextStyle(color: Color(0xFF5252C7),fontSize: 14, decoration: TextDecoration.none,),),
                                  ),
                                  Icon(Icons.message,color: Color(0xFF5252C7),),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text("150",style: TextStyle(color: Color(0xFF5252C7),fontSize: 14, decoration: TextDecoration.none,),),
                                ),
                                Icon(Icons.favorite_border,color:Color(0xFF5252C7)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ItemComment(),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

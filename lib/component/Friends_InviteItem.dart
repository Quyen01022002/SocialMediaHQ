import 'package:flutter/material.dart';

class ItemInvite extends StatefulWidget {
  const ItemInvite({Key? key}) : super(key: key);

  @override
  State<ItemInvite> createState() => _ItemInviteState();
}

class _ItemInviteState extends State<ItemInvite> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,16,0,16),
      child: Container(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: ClipOval(
                child: Image.asset(
                  "assets/images/backgourd.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Trần Bửu Quyến",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 6,),
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        "assets/images/backgourd.png",
                        width: 15,
                        height: 15,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text("1 bạn chung")
                  ],
                ),
                const SizedBox(height: 6,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 28.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF8587F1),
                          ),
                          onPressed: () {},
                          child: Text("Chấp nhận")),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFD7D4D4),
                        ),
                        onPressed: () {},
                        child: Text("Xóa")),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}


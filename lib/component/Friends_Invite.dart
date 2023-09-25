import 'package:flutter/material.dart';
import 'package:socialmediahq/component/Friends_InviteItem.dart';


class InviteComponent extends StatelessWidget {
  const InviteComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF3F5F7),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: RichText(
                  text: const TextSpan(
                    text: "Lời mời kết bạn",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    children: <TextSpan>[
                      TextSpan(
                        text: '14',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 26, 16, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int index = 0; index < 3; index++)
                    ItemInvite(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

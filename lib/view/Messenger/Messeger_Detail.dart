import 'package:flutter/material.dart';
import 'package:socialmediahq/component/MessegerHeader.dart';

class MessegerDetail extends StatelessWidget {
  const MessegerDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: MessegerHeader(),
      ),
    );
  }
}

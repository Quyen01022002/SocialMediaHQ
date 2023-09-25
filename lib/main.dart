import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/route/app_pages.dart';
import 'package:socialmediahq/route/app_route.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

   @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages:AppPages.list ,
      initialRoute:AppRoute.dashboard ,
      debugShowCheckedModeBanner: false,
    );
  }
}




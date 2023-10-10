import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/route/app_pages.dart';
import 'package:socialmediahq/route/app_route.dart';
import 'package:provider/provider.dart';
import 'package:socialmediahq/service/UserProvider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: MyApp(),
  ),);
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





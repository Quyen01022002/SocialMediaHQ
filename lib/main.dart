import 'dart:io';

import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/route/app_pages.dart';
import 'package:socialmediahq/route/app_route.dart';
import 'package:provider/provider.dart';
import 'package:socialmediahq/service/UserProvider.dart';


void main() async {
  CloudinaryContext.cloudinary = Cloudinary.fromCloudName(
      cloudName: "dq21kejpj",
      apiKey: "956346376868569"
  );
    WidgetsFlutterBinding.ensureInitialized();
    Platform.isAndroid ?
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBQQ6cv9yCTPedmmFkbKh4X_1dB5LNDxxg",
            appId: "1:543097789050:android:8c6b764246a8f3525339c3",
            databaseURL: "https://socialmedia-b2509-default-rtdb.asia-southeast1.firebasedatabase.app",
            storageBucket: "socialmedia-b2509.appspot.com",
            messagingSenderId: "543097789050",
            projectId: "socialmedia-b2509")
    ):
    await Firebase.initializeApp();
    WidgetsFlutterBinding.ensureInitialized();
    runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),);

}

class MyApp extends StatelessWidget {

  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.list,
      initialRoute: AppRoute.dashboard,
      debugShowCheckedModeBanner: false,
    );
  }

}





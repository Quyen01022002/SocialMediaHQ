import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:socialmediahq/route/app_pages.dart';
import 'package:socialmediahq/route/app_route.dart';
import 'package:provider/provider.dart';
import 'package:socialmediahq/service/UserProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBQQ6cv9yCTPedmmFkbKh4X_1dB5LNDxxg",
      appId: "1:543097789050:android:8c6b764246a8f3525339c3",
      databaseURL: "https://socialmedia-b2509-default-rtdb.asia-southeast1.firebasedatabase.app",
      storageBucket: "socialmedia-b2509.appspot.com",
      messagingSenderId: "543097789050",
      projectId: "socialmedia-b2509",
    ),
  );

  CloudinaryContext.cloudinary = Cloudinary.fromCloudName(
    cloudName: "dq21kejpj",
    apiKey: "956346376868569",
  );

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'basic_channel',
        channelDescription: 'Kênh thông báo cho thông báo cơ bản',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
      ),
    ],
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("onMessage: $message");

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: message.messageId.hashCode,
        channelKey: 'basic_channel',
        title: message.notification!.title,
        body: message.notification!.body,
        bigPicture: 'asset://assets/images/logo.png', // Đường dẫn tới ảnh lớn
      ),
    );
  });
  await FirebaseMessaging.instance.requestPermission(
    sound: true,
    badge: true,
    alert: true,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
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

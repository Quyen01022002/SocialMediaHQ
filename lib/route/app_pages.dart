
import 'package:get/get.dart';
import 'package:socialmediahq/route/app_route.dart';

import 'package:socialmediahq/view/authen/splash_screen.dart';


class AppPages
{
  static var list =[
    GetPage(name: AppRoute.dashboard,page: ()=>const SplashScreen(animated:false))
  ];
}
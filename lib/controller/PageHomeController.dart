import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/model/PageModel.dart';

import '../model/PageLoad.dart';
import '../service/API_Page.dart';

class PageHomeController extends GetxController{
  RxInt page_id = 0.obs;
  PageModel? pageCurrent;

  final textControllerDescriptionPage = TextEditingController();
  final textControllerNamePage = TextEditingController();

  Future<void> CreatePage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id')??0;
    final token = prefs.getString('token')??"";

    final description = textControllerDescriptionPage.text;
    final name_page = textControllerNamePage.text;
    PageModel newPage = PageModel(
        name: name_page,
        id: 0,
        description: description,
        createDate: DateTime.now(),
        updateDate: DateTime.now());
    PageModel? pageModel = await API_Page.addPage(newPage, token);

  }
  Stream<PageLoad>? pageLoadCurrent;
  Future<void> GetOnePage(int page, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id')??0;
    final token = prefs.getString('token')??"";
    page_id.value = page;
    final token2 = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkb2R1eWhhbzc2NDBAZ21haWwuY29tIiwiaWF0IjoxNzAyNjczMjk0LCJleHAiOjE3MDI2NzQ3MzR9.7dCByBKr0QG6L0cR6egYm9wbm5j1_5eUotCUj4uKUGSOVcDwJ7ph24Ag_rTGUWbSuTum5PZadKibgEN5tgQo7g";
    PageModel? pageModel = await API_Page.getPageById(page_id.value, token);
    pageCurrent = pageModel;
    PageLoad pageLoad = PageLoad(
        pageModel: pageModel,
        isLiked: true,
        isFollowing: true,
        countLiked: 12,
        countFollowing: 15);
    pageLoadCurrent = Stream.fromIterable([pageLoad!]);
    int i =0;
  }

  void UpdatePage(BuildContext context){



  }


  Future<void> DeletePage(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id')??0;
    final token = prefs.getString('token')??"";
    await API_Page.deletePageById(pageCurrent!, token);
    //loadPage();
    Future.delayed(Duration(milliseconds: 100), () {
      int count =0;
      Navigator.of(context).popUntil((_) => count++ >= 2);
    });
  }

  List<PageModel>? allPage = [];
  List<PageModel>? followingPage = [];
  List<PageModel>? likedPage = [];
  Stream<List<PageModel>>? allPageStream;
  Stream<List<PageModel>>? followingPageStream;
  Stream<List<PageModel>>? likedPageStream;
  Future<void> loadPage() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    List<PageModel>? resultAllPage = await API_Page.getAllPageList(token);
    List<PageModel>? resultFollowPage = await API_Page.getFollowPageList(token, userId);
    List<PageModel>? resultLikedPage = await API_Page.getLikedPageList(token, userId);

    allPageStream = Stream.fromIterable([allPage!]);
    followingPageStream = Stream.fromIterable([followingPage!]);
    likedPageStream = Stream.fromIterable([likedPage!]);

  }






}
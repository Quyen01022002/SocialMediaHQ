import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socialmediahq/model/PageModel.dart';

import '../model/PageLoad.dart';
import '../model/UsersEnity.dart';
import '../service/API_Friends.dart';
import '../service/API_Page.dart';
import '../view/Page/ListFriend.dart';

class PageHomeController extends GetxController{
  RxInt page_id = 0.obs;
  PageModel? pageCurrent;
  RxBool isAdmin = false.obs;
  RxBool isFollow= false.obs;
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
        updateDate: DateTime.now(),
    adminId: adminId);
    PageModel? pageModel = await API_Page.addPage(newPage, token);

    pageCurrent = pageModel;
    page_id.value = pageModel!.id!;
    GetOnePage(page_id.value, context);
  }
  Stream<PageLoad>? pageLoadCurrent;
  Future<void> GetOnePage(int page, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id')??0;
    final token = prefs.getString('token')??"";
    page_id.value = page;
    PageModel? pageModel = await API_Page.getPageById(page_id.value, token);
    isFollow.value = await API_Page.checkFollow(adminId, page_id.value, token);
    int count = await API_Page.getCountFollow(page_id.value, token);
    pageCurrent = pageModel;
    if (pageModel!= null)
      {
        if(pageModel.adminId == adminId)
          isAdmin.value = true;
        else
          isAdmin.value = false;
      }
    PageLoad pageLoad = PageLoad(
        pageModel: pageModel,
        isLiked: true,
        isFollowing: isFollow.value,
        countLiked: 12,
        countFollowing: count);

    pageLoadCurrent = Stream.fromIterable([pageLoad!]);
    int i =0;
  }
  Future<void> getInfoPageToUpdate(BuildContext) async {
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id')??0;
    final token = prefs.getString('token')??"";
    pageCurrent = await API_Page.getPageById(page_id.value, token);
    textControllerNamePageUpdate.text = pageCurrent!.name.toString();
    textControllerDescPageUpdate.text = pageCurrent!.description.toString();
  }

  final textControllerDescPageUpdate = TextEditingController();
  final textControllerNamePageUpdate = TextEditingController();
  Future<void> UpdatePage(BuildContext context) async {
    final description = textControllerDescPageUpdate.text;
    final name_page = textControllerNamePageUpdate.text;
    final prefs = await SharedPreferences.getInstance();
    final adminId = prefs.getInt('id')??0;
    final token = prefs.getString('token')??"";
    PageModel? page = await API_Page.getPageById(page_id.value, token);
    PageModel updatePage = PageModel(
        name: name_page,
        id: page_id.value,
        createDate: page?.createDate,
        description: description,
        updateDate: DateTime.now(),
      adminId: adminId
    );

    PageModel? pageModel = await API_Page.updatePage(updatePage, token);
    GetOnePage(page_id.value, context);
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
    if (resultAllPage == null)
      allPageStream = Stream.fromIterable([]);
    else
    allPageStream = Stream.fromIterable([resultAllPage!]);
    if (resultFollowPage==null)
      followingPageStream = Stream.fromIterable([]);
    else
    followingPageStream = Stream.fromIterable([resultFollowPage!]);
    if (resultLikedPage == null)
      likedPageStream = Stream.fromIterable([]);
    else
    likedPageStream = Stream.fromIterable([resultLikedPage!]);

  }


  Future<void> followPage(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    await API_Page.followPage(userId, page_id.value, token);
    GetOnePage(page_id.value, context);
  }

  Future<void> unfollowPage(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    await API_Page.unfollowPage(userId, page_id.value, token);
    GetOnePage(page_id.value, context);
  }

  List<UserEnity>? listUserFr = [];
  Future<void> loadFriends(BuildContext context) async {

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    List<UserEnity>? result = await API_Friend.LoadListFriends(userId, token);
    listUserFr = result;
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListFrScreen()),
    );
  }


  Future<void> updateAdmin(BuildContext context, int iduser) async{
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;
    final token = prefs.getString('token') ?? "";
    await API_Page.updateAdmin(page_id.value,iduser, token);
    GetOnePage(page_id.value, context);

  }



}
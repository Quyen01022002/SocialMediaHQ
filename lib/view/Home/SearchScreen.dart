import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmediahq/component/Home_Header.dart';
import 'package:socialmediahq/model/UsersEnity.dart';

import '../../component/Friends_FollowItem.dart';
import '../../controller/SearchController.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Search_Controller myController = Get.put(Search_Controller());
  List<UserEnity> _searchResults = [];

  Future<void> _searchData(String query) async {
    myController.loadUser();
    setState(() {
      _searchResults = myController.listUser;
    });
  }

  Future<List<String>> fetchSearchResultsFromApi(String query) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(5, (index) => 'Result $index for "$query"');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 50,
                child: TextField(
                  controller: myController.textControllerContent,
                  onChanged: (query) {
                    _searchData(query);
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Search....",
                  ),
                ),
              ),
            ),
            Expanded(
              child: _buildSearchResults(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return SingleChildScrollView(
      child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              key: ValueKey(_searchResults),
              children: _searchResults
                  .map((item) => ItemFollow(
                friends: item,
              ))
                  .toList(),
            ),
          )
    );
  }
}

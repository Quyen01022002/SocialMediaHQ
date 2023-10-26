import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:socialmediahq/model/UserModel.dart';
import 'package:socialmediahq/service/UserProvider.dart';
import 'package:socialmediahq/view/authen/Login_screen.dart';
import 'package:socialmediahq/view/dashboard/DashBoard.dart';


class GoogleSignInProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  bool isSignedIn = false;
  GoogleSignInAccount? _currentUser;
  Future<bool> getUserData() async {

    if(_currentUser!=null)
      {
        return true;
      }
    else
      {
    return false;}
  }
  Future<void> handleSignIn(BuildContext context) async {
    try {
      await _googleSignIn.signIn();
      _currentUser = _googleSignIn.currentUser;

      if (_currentUser != null) {
        final userModel = UserModel(
          userName: _currentUser!.displayName ?? '',
          email: _currentUser!.email ?? '',
          avatarUrl: _currentUser!.photoUrl ?? '',
        );
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userModel);
        isSignedIn = true;
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashBoard()),
      );
    } catch (error) {
      print(error);
    }
  }
  String? getFirstName() {
    if (_currentUser != null) {

      List<String> nameParts = _currentUser!.displayName!.split(" ");
      if (nameParts.isNotEmpty) {
        // Lấy phần tử đầu tiên là first name
        return nameParts[0];
      }
    }
    return null; // Trả về null nếu không có tên hoặc lỗi
  }

  String? getLastName() {
    if (_currentUser != null) {
      // Tách tên thành first name và last name bằng cách sử dụng khoảng trắng làm dấu phân cách
      List<String> nameParts = _currentUser!.displayName!.split(" ");
      if (nameParts.length > 1) {
        // Lấy phần tử cuối cùng là last name
        return nameParts[nameParts.length - 1];
      }
    }
    return null; // Trả về null nếu không có tên hoặc lỗi
  }

  Future<void> handleSignOut(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(null);
      isSignedIn = false;
      Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.rightToLeft,
          child: Loginscreen(animated: false,),
        ),
      );
    } catch (error) {
      print(error);
    }
  }
}

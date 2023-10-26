import 'package:flutter/foundation.dart';
import 'package:socialmediahq/model/UserModel.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user; // Thông tin người dùng

  // Hàm để lưu thông tin người dùng sau khi đăng nhập
  void setUser(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  // Getter để truy cập thông tin người dùng từ bất kỳ đâu trong ứng dụng
  UserModel? get user => _user;
  bool get isLoggedIn => _user != null;
}

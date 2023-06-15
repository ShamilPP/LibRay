import 'package:flutter/material.dart';
import 'package:libray/utlis/enum/user.dart';

class ApplicationProvider extends ChangeNotifier {
  String _title = 'LibRay';
  User _user = User.student;

  String get title => _title;

  User get user => _user;

  void setUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  void setTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }
}

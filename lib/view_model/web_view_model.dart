import 'package:flutter/material.dart';
import 'package:gbhss_library/service/web_service.dart';
import 'package:gbhss_library/utlis/enum/status.dart';
import 'package:gbhss_library/utlis/enum/user.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utlis/constants.dart';

class WebProvider extends ChangeNotifier {
  Status _webStatus = Status.failed;
  User _currentUser = User.student;
  WebViewController? _webViewController;

  Status get webStatus => _webStatus;

  User get currentUser => _currentUser;

  WebViewController? get webViewController => _webViewController;

  void checkConnectivity() async {
    _webStatus = Status.loading;
    notifyListeners();
    bool isStable = await WebService.checkConnection(_currentUser == User.student ? studentUrl : teacherUrl);
    if (isStable) {
      _webStatus = Status.success;
    } else {
      _webStatus = Status.failed;
    }
    notifyListeners();
  }

  void setUser(User user) {
    _currentUser = user;
    checkConnectivity();

    notifyListeners();
  }

  void setController(WebViewController controller) {
    _webViewController=controller;
  }
}

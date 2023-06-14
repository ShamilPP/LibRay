import 'package:flutter/material.dart';
import 'package:gbhss_library/service/web_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../model/result.dart';

class WebProvider extends ChangeNotifier {
  late String _ip;
  late String _port;
  Status _webStatus = Status.loading;
  WebViewController? _webViewController;

  Status get webStatus => _webStatus;

  String get ip => _ip;

  String get port => _port;

  String get url => 'http://$ip:$port';

  WebViewController? get webViewController => _webViewController;

  void updateConnectivity() async {
    _webStatus = Status.loading;
    notifyListeners();
    bool isStable = await WebService.checkConnection(url);
    if (isStable) {
      _webStatus = Status.success;
    } else {
      _webStatus = Status.error;
    }
    notifyListeners();
  }

  void setIp(String newIp) {
    _ip = newIp;
  }

  void setPort(String newPort) {
    _port = newPort;
  }

  void setController(WebViewController controller) {
    _webViewController = controller;
  }
}

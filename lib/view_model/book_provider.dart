import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:libray/service/api_service.dart';

import '../model/book.dart';
import '../model/result.dart';

class BookProvider extends ChangeNotifier {
  late Book _book;
  Status _status = Status.initial;

  Book get book => _book;

  Status get status => _status;

  void loadBook(int isbn) {
    _status = Status.loading;
    ApiService.getBookWithISBN(isbn).then((result) {
      _status = result.status;
      if (_status == Status.success && result.data != null) {
        _book = result.data!;
      } else {
        Fluttertoast.showToast(msg: result.message!);
      }
      notifyListeners();
    });
  }
}

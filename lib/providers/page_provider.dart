import 'package:flutter/cupertino.dart';

class PageProvider extends ChangeNotifier {
  int _pageindex = 0;
  int get pageindex => _pageindex;

  void updatePageIndex(int newindex) {
    _pageindex = newindex;
    notifyListeners();
  }
}

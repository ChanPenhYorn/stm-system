import 'package:flutter/material.dart';

class ProviderListener with ChangeNotifier {
  ChangeNotifier? cartOrder = ChangeNotifier();

  int slideIndex = 0;

  void setImageSlideIndex(int index) {
    slideIndex = index;
    notifyListeners();
  }

  saleOrderRefresh() {
    notifyListeners();
  }

  onlineUserRefresh() {
    notifyListeners();
  }
}

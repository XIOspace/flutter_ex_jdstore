
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class BottomNaviProvider with ChangeNotifier{
  int bottomNaviIndex = 0;

  void changeBottomNaviIndex(int index){
    if(bottomNaviIndex != index){
      bottomNaviIndex = index;
      notifyListeners();
    }
  }
}
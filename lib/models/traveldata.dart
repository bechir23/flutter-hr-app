import 'package:flutter/cupertino.dart';

class traveldata extends ChangeNotifier {
  List<bool> values = [];
  int selectedIdx = -1;
 

  void increment() {
    int newIndex = values.length;
    values.add(false);
    selectedIdx = newIndex; // Set the selected index when a new item is added
    notifyListeners();
  }

  
}

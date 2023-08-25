import 'package:flutter/material.dart';


class projectdata extends ChangeNotifier {
  List<bool> values = [];
 int selectedIdx=-1 ;
  List<String> selected=['','',''];

void init(){values = [];selectedIdx = -1;  selected[0]='';selected[1]='';selected[2]='';notifyListeners();}

  
}

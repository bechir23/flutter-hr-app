import 'package:flutter/material.dart';

class fileview extends ChangeNotifier{
List<bool> values=[true,false];
String selected='Active Employee Based';
void init(){values=[true,false];selected='Active Employee Based';notifyListeners();}
void update(int index,String d){
values[index]=true;
for (int i=0;i<values.length;i++) { if(i!=index) {values[i]=false;}}

selected=d;
notifyListeners();}

}



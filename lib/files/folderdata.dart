import 'package:flutter/material.dart';

class folderdata extends ChangeNotifier{
List<bool> values=[];
String selected='SELECT';
void init(){values=[];selected='SELECT';notifyListeners();}
void update(int index,String d){
values[index]=true;
for (int i=0;i<values.length;i++) { if(i!=index) {values[i]=false;}}

selected=d;
notifyListeners();}

}
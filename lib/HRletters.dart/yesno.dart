import 'package:flutter/material.dart';

class yesno extends ChangeNotifier{

List<bool> values=[false,false];
String scale='SELECT' ;
void update(index,value)
{values[index]=value;
notifyListeners();}
void Done()
{
 values[0]? scale='Yes': scale='No';
 notifyListeners(); 
}
void init() {values=[false,false];scale='SELECT';notifyListeners();}







}
import 'package:flutter/material.dart';
class check extends ChangeNotifier {
List<bool> values=[false,false,false];
String scale='low' ;
void update(index,value)
{values[index]=value;
notifyListeners();}
void Done()
{
 values[0]? scale='High':values[1]? scale='Moderate':scale='Low';
 notifyListeners(); 
}
void init() {values=[false,false,false];scale='low';notifyListeners();}
}
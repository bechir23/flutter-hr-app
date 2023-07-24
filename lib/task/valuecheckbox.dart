import 'package:flutter/material.dart';
class check extends ChangeNotifier {
List<bool> values=[false,false,false];
String scale='low' ;
void Done()
{
 values[0]? scale='High':values[1]? scale='Moderate':scale='Low';
 notifyListeners(); 
}
}
import 'package:flutter/material.dart';
import 'package:myapp/Travel/Newplace.dart';

class traveldata extends ChangeNotifier
{List<bool> values=[];
String text1='UNDIFINED';
String text2='UNDIFINED';

  List <visitplacepurpose> visits=[];
int i=-1;
void increment(String a,String b)
{i++;
values.add(false); 
visits.add(visitplacepurpose(visitplace: a, visitpurpose: b)) ;
 notifyListeners();}



void update()
{
  for(int j=0;j<values.length;j++)
  {if (values[j]==true) {text1=visits[j].visitplace;text2=visits[j].visitpurpose;break;}
  
  
  
  }
}}
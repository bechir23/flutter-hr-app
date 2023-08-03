import 'package:flutter/material.dart';
class 
detailsdata extends ChangeNotifier{
String a='';
String b='';
List<Map <String, dynamic>> documents=[];
void add(Map <String, dynamic> d){documents.add(d);}
void init(){a='';b='';documents=[];}



}
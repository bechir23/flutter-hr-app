import 'package:flutter/material.dart';

class medicaldata extends ChangeNotifier{
String currency='QAR';

List<Map <String, dynamic>> documents=[];
void add(Map <String, dynamic> d){documents.add(d);notifyListeners();}
void init(){documents=[];currency='QAR';notifyListeners();}

void update(String value){currency=value;notifyListeners();}









}
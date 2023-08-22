import 'package:flutter/material.dart';



class assets extends ChangeNotifier{
String scale='SELECT';
  List  <String>  types=['Computer','Laptop','Books','Mobile','Phone','Vehicle'];List<bool> values=[false,false,false,false,false,false];
void update(index,value)
{values[index]=value;

for (int i=0;i<types.length;i++)
{if (i!=index) {values[i]=false;}
 }
scale=types[index];notifyListeners();
}

void init()
{ scale='SELECT';
 values=[false,false,false,false,false,false];
 notifyListeners();

}


}
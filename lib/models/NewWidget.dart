import 'package:flutter/material.dart';
import 'package:myapp/task/TaskScreen.dart';

class NewTask extends StatelessWidget {
  final String name;
  final String press;
  NewTask({required this.name,required this.press});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(100),
      child: Container(
        
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all( Radius.circular(20))),
        
        child: GestureDetector(
          onTap: (){Navigator.pushNamed(context, press);},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children:[
             Icon(
              Icons.airplane_ticket,
             ),
              
              SizedBox(height: 10,),
               Text(name!,textAlign:TextAlign.center,
            style:TextStyle(fontSize: 50,fontWeight: FontWeight.bold))]
          ),
        ),
      ),
    ) ;
  }
}
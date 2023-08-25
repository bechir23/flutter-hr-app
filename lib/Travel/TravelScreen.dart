import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/index.dart';

class travelscreen extends StatefulWidget {
  static const  String screenroute='travel';
  const travelscreen({super.key});

  @override
  State<travelscreen> createState() => _travelscreenState();
}

class _travelscreenState extends State<travelscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 114, 152),
        leading: IconButton(icon: const Icon(Icons.exit_to_app),onPressed: ()  {
     
          setState(() {
          Provider.of<pos>(context,listen: false).index=1;
          Navigator.pushNamed(context,'navigation');
      
        });
        
      },),title: const Text('Travel',style: TextStyle(color: Colors.white,fontSize: 40),),centerTitle: true,),
        backgroundColor: const Color.fromARGB(255, 240, 128, 165),
        body: ListView(
        children: [ GestureDetector(
          onTap: (){Navigator.pushNamed(context, 'request');},
          child: const ListTile(
            title: Text('Travel Request'),trailing: Icon(Icons.skip_next),
          ),
        ),
         GestureDetector(
           onTap: (){Navigator.pushNamed(context, 'expense');},
           child: const ListTile(
             title: Text('Travel Expense'),trailing: Icon(Icons.skip_next),
                 ),
         ),
        
        ]),
      );  
  }
}
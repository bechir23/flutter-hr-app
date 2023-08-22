import 'package:flutter/material.dart';

class letterscreen extends StatefulWidget {
  static const String screenroute='letter';
  const letterscreen({super.key});

  @override
  State<letterscreen> createState() => _letterscreenState();
}

class _letterscreenState extends State<letterscreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 114, 152),
        leading: IconButton(icon: const Icon(Icons.exit_to_app),onPressed: ()  {
     
          setState(() {
         
          Navigator.pop(context);
      
        });
        
      },),title: const Text('HR Letters',style: TextStyle(color: Colors.white,fontSize: 40),),centerTitle: true,),
        backgroundColor: const Color.fromARGB(255, 240, 128, 165),
        body: ListView(
        children: [ GestureDetector(
          onTap: (){Navigator.pushNamed(context, 'proof');},
          child: const ListTile(
            title: Text('Address Proof'),trailing: Icon(Icons.skip_next),
          ),
        ),
         GestureDetector(
           onTap: (){Navigator.pushNamed(context, 'bonafide');},
           child: const ListTile(
             title: Text('Bonafide Letter'),trailing: Icon(Icons.skip_next),
                 ),
         ),
          GestureDetector(
           onTap: (){Navigator.pushNamed(context, 'experience');},
           child: const ListTile(
             title: Text('Experience Letter'),trailing: Icon(Icons.skip_next),
                 ),
         ),
        ]),
      );  
  }
}
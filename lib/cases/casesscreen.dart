import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../task/valuecheckbox.dart';

class casesscreen extends StatefulWidget {
  static const String screenroute='cases';
  const casesscreen({super.key});

  @override
  State<casesscreen> createState() => _casesscreenState();
}

class _casesscreenState extends State<casesscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 114, 152),
        leading: IconButton(icon: const Icon(Icons.exit_to_app),onPressed: ()  {
     
          setState(() {
                  Provider.of<check>(context,listen: false).init();

          Navigator.pop(context);
      
        });
        
      },),title: const Text('Ask a question',style: TextStyle(color: Colors.white,fontSize: 40),),centerTitle: true,),
        backgroundColor: const Color.fromARGB(255, 240, 128, 165),
        body: ListView(
       children:[GestureDetector(
          onTap: (){Navigator.pushNamed(context, 'questions');},
          child: const ListTile(
            leading: Icon(Icons.star),
            subtitle: Text('Post all your general questions',style: TextStyle(color: Colors.grey),),
            title: Text('General Queries'),trailing: Icon(Icons.skip_next),
          ),
        ),
         
        
        ]),
      );  
  }
} 
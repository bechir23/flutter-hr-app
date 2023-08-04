import 'package:flutter/material.dart';
import 'package:myapp/files/fileview.dart';
import 'package:provider/provider.dart';

class view extends StatefulWidget {
  static const screenroute='view';
  const view({super.key});

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  @override
  Widget build(BuildContext context) {
 return   Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 114, 152),
        leading: IconButton(icon: const Icon(Icons.exit_to_app),onPressed: ()  {
     
          setState(() {
         
          Navigator.pop(context);
      
        });
        
      },),title: const Text('File View',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 40),),),
        backgroundColor: const Color.fromARGB(255, 240, 128, 165),
        body: ListView(
        children:[ ListTile(
          title: const Text('Active Employee Based'),trailing: Checkbox(value:Provider.of<fileview>(context,listen: false).values[0],onChanged: (value) {
          setState(() {
              
               Provider.of<fileview>(context,listen: false).update(0,'Active Employee Based');

    
           
          });  
          },),
        ),
         ListTile(
          title: const Text('Role Based'),trailing: Checkbox(value:  Provider.of<fileview>(context,listen: false).values[1],onChanged: (value) {
                  setState(() {
                 
           Provider.of<fileview>(context,listen: false).update(1,'Role Based');
    
                  });  
      
          },),
        ),
       
        
        ]),
      );  
   
  } } 
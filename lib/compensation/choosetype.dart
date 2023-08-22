import 'package:flutter/material.dart';
import 'package:myapp/compensation/typeassets.dart';
import 'package:provider/provider.dart';

class choosetype extends StatefulWidget {
  static const screenroute='type';
  const choosetype({super.key});

  @override
  State<choosetype> createState() => _choosetypeState();
}

class _choosetypeState extends State<choosetype> {
  @override
  Widget build(BuildContext context) {
    
    
    return   Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 114, 152),
        leading: IconButton(icon: const Icon(Icons.exit_to_app),onPressed: ()  {
          setState(() {
         
          Navigator.pop(context);
      
        });
        
      },),title: const Text('Type Of Assets',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 40),),),
        backgroundColor: const Color.fromARGB(255, 240, 128, 165),
        body:Consumer<assets>(
      builder:(context, Data, child) {return ListView.builder(
        itemCount:Data.types.length,
        itemBuilder:(context,index) {
        return ListTile(
          title: Text(Data.types[index]),trailing: Checkbox(value:Data.values[index],onChanged: (value) {
          setState(() {
                   Data.update(index, value!);
                 
    
    
           
          });  
          },),
        ) ;
          
      },
      );
  })
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
      
      );  
   
  } } 
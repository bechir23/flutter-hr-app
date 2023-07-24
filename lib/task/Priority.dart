import 'package:flutter/material.dart';
import 'package:myapp/task/valuecheckbox.dart';
import 'package:provider/provider.dart';
class Degree extends StatefulWidget {
  static const  String screenroute='priority';
   const Degree({super.key});
   
     

  @override
  State<Degree> createState() => _DegreeState();
}

class _DegreeState extends State<Degree> {
  

  @override
  Widget build(BuildContext context) {
    
    
    return   Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 228, 114, 152),
        leading: IconButton(icon: Icon(Icons.exit_to_app),onPressed: () {setState(() {
          Provider.of<check>(context,listen: false).Done();
          Navigator.pop(context);
      
        });
        
      },),title: Text('Priority',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 40),),),
        backgroundColor: Color.fromARGB(255, 240, 128, 165),
        body: Container(
          child: ListView(
          children:[ ListTile(
            title: const Text('High'),trailing: Checkbox(value:Provider.of<check>(context,listen: false).values[0],onChanged: (value) {
            setState(() {
                   
              Provider.of<check>(context,listen: false).values[0]=value!;
                         Provider.of<check>(context,listen: false).values[2]=false;
              Provider.of<check>(context,listen: false).values[1]=false;
          //    Provider.of<check>(context,listen: false).Done();
    
    
             
            });  
            },),
          ),
           ListTile(
            title: Text('Moderate'),trailing: Checkbox(value:  Provider.of<check>(context,listen: false).values[1],onChanged: (value) {
                    setState(() {
                   
              Provider.of<check>(context,listen: false).values[1]=value!;
                         Provider.of<check>(context,listen: false).values[2]=false;
              Provider.of<check>(context,listen: false).values[0]=false;
    
             //      Provider.of<check>(context,listen: false).Done();
                      
    
                    });  
      
            },),
          ),
           ListTile(
            title: Text('Low'),trailing: Checkbox(value:  Provider.of<check>(context).values[2],onChanged: (value) {
                   setState(() {
              Provider.of<check>(context,listen: false).values[2]=value!;
                          Provider.of<check>(context,listen: false).values[0]=false;
              Provider.of<check>(context,listen: false).values[1]=false;
    //Provider.of<check>(context,listen: false).Done();
              
                   
            });
                        
      
            },),
          ),
        
          ]),
        ),
      );  
   
  } } 
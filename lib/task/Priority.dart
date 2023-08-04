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
        backgroundColor: const Color.fromARGB(255, 228, 114, 152),
        leading: IconButton(icon: const Icon(Icons.exit_to_app),onPressed: ()  {
     Provider.of<check>(context,listen:false).Done();
          setState(() {
         
          Navigator.pop(context);
      
        });
        
      },),title: const Text('Priority',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 40),),),
        backgroundColor: const Color.fromARGB(255, 240, 128, 165),
        body: ListView(
        children:[ ListTile(
          title: const Text('High'),trailing: Checkbox(value:Provider.of<check>(context,listen: false).values[0],onChanged: (value) {
          setState(() {
                   Provider.of<check>(context,listen: false).update(0, value!);
                       Provider.of<check>(context,listen: false).update(1, false);
            Provider.of<check>(context,listen: false).update(2, false);
           
        //    Provider.of<check>(context,listen: false).Done();
    
    
           
          });  
          },),
        ),
         ListTile(
          title: const Text('Moderate'),trailing: Checkbox(value:  Provider.of<check>(context,listen: false).values[1],onChanged: (value) {
                  setState(() {
                 
                  Provider.of<check>(context,listen: false).update(1, value!);
                       Provider.of<check>(context,listen: false).update(2, false);
            Provider.of<check>(context,listen: false).update(0, false);
           //      Provider.of<check>(context,listen: false).Done();
                    
    
                  });  
      
          },),
        ),
         ListTile(
          title: const Text('Low'),trailing: Checkbox(value:  Provider.of<check>(context).values[2],onChanged: (value) {
                 setState(() {
                   Provider.of<check>(context,listen: false).update(2, value!);
                       Provider.of<check>(context,listen: false).update(1, false);
            Provider.of<check>(context,listen: false).update(0, false);
            
           // Provider.of<check>(context,listen: false).values[2]=value!;
           //             Provider.of<check>(context,listen: false).values[0]=false;
         //   Provider.of<check>(context,listen: false).values[1]=false;
            
    //Provider.of<check>(context,listen: false).Done();
            
                 
          });
                      
      
          },),
        ),
        
        ]),
      );  
   
  } } 
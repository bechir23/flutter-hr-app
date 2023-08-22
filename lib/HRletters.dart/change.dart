import 'package:flutter/material.dart';
import 'package:myapp/HRletters.dart/yesno.dart';
import 'package:provider/provider.dart';

class change extends StatefulWidget {
  static const String screenroute='change';
  const change({super.key});

  @override
  State<change> createState() => _changeState();
}

class _changeState extends State<change> {
  @override
  Widget build(BuildContext context) {
 
    return   Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 114, 152),
        leading: IconButton(icon: const Icon(Icons.exit_to_app),onPressed: ()  {
     Provider.of<yesno>(context,listen:false).Done();
          setState(() {
         
          Navigator.pop(context);
      
        });
        
      },),title: const Text('IS there any change in Present Address',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 40),),),
        backgroundColor: const Color.fromARGB(255, 240, 128, 165),
        body: ListView(
        children:[ ListTile(
          title: const Text('YES'),trailing: Checkbox(value:Provider.of<yesno>(context,listen: false).values[0],onChanged: (value) {
          setState(() {
                   Provider.of<yesno>(context,listen: false).update(0, value!);
                       Provider.of<yesno>(context,listen: false).update(1, false);
           
        //    Provider.of<check>(context,listen: false).Done();
    
    
           
          });  
          },),
        ),
         ListTile(
          title: const Text('NO'),trailing: Checkbox(value:  Provider.of<yesno>(context,listen: false).values[1],onChanged: (value) {
                  setState(() {
                 
                  Provider.of<yesno>(context,listen: false).update(1, value!);
            Provider.of<yesno>(context,listen: false).update(0, false);
           //      Provider.of<check>(context,listen: false).Done();
                    
    
                  });  
      
          },),
        ),
       
        
        ]),
      );  
   
  } } 
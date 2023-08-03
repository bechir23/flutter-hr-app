import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/files/ADDFILE.dart';

class folder extends StatefulWidget {
  static const String screenroute='folder';
  const folder({super.key});

  @override
  State<folder> createState() => _folderState();
}

class _folderState extends State<folder> {
  @override
  Widget build(BuildContext context) {
   
    return   Scaffold(
      appBar: AppBar(actions: [ IconButton(icon: const Icon(Icons.add),onPressed: ()  {
     //Provider.of<check>(context,listen:false).Done();
          setState(() {
         
showDialog(context: context, builder:(BuildContext  context) {
  return const AddFILE();
})     ; 
        });
        
      })],
        backgroundColor: const Color.fromARGB(255, 228, 114, 152),
        leading: IconButton(icon: const Icon(Icons.exit_to_app),onPressed: ()  {
     //Provider.of<check>(context,listen:false).Done();
          setState(() {
         
          Navigator.pop(context);
      
        });
        
      },),title: const Text('Select Folder',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 40),),),
        backgroundColor: const Color.fromARGB(255, 240, 128, 165),
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('foldernames').snapshots(),
      builder:(BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot )
      {
        if(snapshot.hasError) { return const Center(child: Text('No folders found'));}
        if (snapshot.connectionState==ConnectionState.waiting)
        {return const Center(child: CircularProgressIndicator());}
     
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document)
          {Map<String,dynamic> data =document.data()! as Map<String,dynamic> ;
             if (data['name'] == null) {
      return const SizedBox(); // You can return an empty widget or handle this case as per your requirement.
    }
            return ListTile(
            title: Text(data['name']),trailing: Checkbox(value:false,onChanged: (value) {
            setState(() {
                 
    
             
            });  
            },), 
          );
          }).toList(),
                  
    
        );
    // if(snapshot.hasData && snapshot.data!.docs.isNotEmpty) {               return Center(child: const Text('No tasks found'));
    
             
    },
    
    
    )
      );  
   
  } } 


      //Provider.of<check>(context,listen: false).update(0, value!);
       //                  Provider.of<check>(context,listen: false).update(1, false);
     //         Provider.of<check>(context,listen: false).update(2, false);
             
   //           Provider.of<check>(context,listen: false).Done();
 // value:  Provider.of<check>(context,listen: false).values[0]
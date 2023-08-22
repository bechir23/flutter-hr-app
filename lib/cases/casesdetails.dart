
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class casesdetails extends StatefulWidget {
  
   static const  String screenroute='casesdetails';

 final  Map <String, dynamic>  m ;
   final String  d  ;
    
   const casesdetails({super.key, required this.m, required this.d} ); 

  @override
  State<casesdetails> createState() => _casesdetailsState();
}

class _casesdetailsState extends State<casesdetails> {  bool _showAttachment=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: AppBar(centerTitle: true,backgroundColor: const Color.fromARGB(255, 192, 109, 137),
   title: const Text('Query Details',style: TextStyle(color: Colors.white,fontSize: 40)),
  
   leading:Row(
     children:[
       Expanded(child: IconButton(onPressed: (){
     Navigator.pop(context);}, icon: const Icon(Icons.exit_to_app))),
    const  SizedBox(width: 30,)
,      Expanded(child: IconButton(onPressed: (){FirebaseFirestore.instance.collection('question').doc(widget.d).delete();
     Navigator.pop(context);}, icon: const Icon(Icons.delete))),]
   ),



    ),
    body:Padding(
      padding: const EdgeInsets.all(20.0),



      child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
        children:[
             const Text('email',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

            Text(widget.m['email'] ?? 'Not found',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                                  const Text('Priority',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

              Text(widget.m['priority']?? 'Not found',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                           
                                         const Text('Query',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

                              Text(widget.m['query']?? 'Not found',style:const TextStyle(fontSize: 20,color: Colors.blue),),

  const Text('Attachment',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),
      GestureDetector(
          onTap: () {
            setattachment(); 
          },
          child: const Text('Query Attachment'),
        ),

        if (_showAttachment)
          Expanded(
            child: getattachment(),
          ),
      
    






        ]


      
      
      ),
    ),



    );
  }

 
Widget getattachment() {
    final String? filePath = widget.m['path'];
    if (filePath != null) {
      return Image.file(
          File(filePath),
          height: 200,
        );
    } else {
     
      return Container();
    }
  }

void setattachment() { setState(() {
      _showAttachment = !_showAttachment;
    });
}
 
}
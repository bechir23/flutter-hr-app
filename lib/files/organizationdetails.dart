import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:myapp/files/folderdata.dart';
import 'package:provider/provider.dart';


class Organizationdetails extends StatefulWidget {
  static const  String screenroute='organizationdetails';

 final  Map <String, dynamic>  m ;
   final String  d  ;

   const Organizationdetails({super.key, required this.m, required this.d} ); 

  @override
  State<Organizationdetails> createState() => _OrganizationdetailsState();
}

class _OrganizationdetailsState extends State<Organizationdetails> {
  bool _showAttachment=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: AppBar(centerTitle: true,backgroundColor: const Color.fromARGB(255, 192, 109, 137),
   title: const Text('Details',style: TextStyle(color: Colors.white,fontSize: 40)),
  
   leading:Row(children: [
   
     
    
   Expanded(child: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.exit_to_app_rounded))),
   const SizedBox(width: 10,),
   //email==d['email] ? .......:container 
     Expanded(child: IconButton(onPressed: (){FirebaseFirestore.instance.collection('organization').doc(widget.d).delete();
     Navigator.pop(context);}, icon: const Icon(Icons.delete)))

   
   
   
   ]),



    ),
    body:Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
        children:[
             const Text('File Name',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

            Text(widget.m['name'] ?? 'not enregistred',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                                          const Text('Description',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

                              Text(widget.m['description']?? 'No email available',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                            
                                        const Text('Folder',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),
                                Text(Provider.of<folderdata>(context,listen: false).selected,style:const TextStyle(fontSize: 20,color: Colors.blue),),         
                                          const Text('Valid Until',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),
                                       

            Text('${widget.m['valid']?.toDate().year}-${widget.m['valid']?.toDate().month.toString().padLeft(2, '0')}-${widget.m['valid']?.toDate().day.toString().padLeft(2, '0')} ${widget.m['valid']?.toDate().hour.toString().padLeft(2, '0')}:${widget.m['valid']?.toDate().minute.toString().padLeft(2, '0')}:${widget.m['valid']?.toDate().second.toString().padLeft(2, '0')}',style:const TextStyle(fontSize: 20,color: Colors.blue)),
                                
       const Text('File Attachment',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),
      GestureDetector(
          onTap: () {
            setattachment(); 
          },
          child: const Text('File Attachment'),
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
      if (filePath.endsWith('.pdf')) {
        
        return PDFView(
          filePath: filePath,
        );
      } else {
        
        return Image.file(
          File(filePath),
          height: 200,
        );
      }
    } else {
     
      return Container();
    }
  }

void setattachment() { setState(() {
      _showAttachment = !_showAttachment;
    });
}
 
}
 //tnahi l widget.m w tnahi stateful w l button w tkhalleha keka bl if kahaw
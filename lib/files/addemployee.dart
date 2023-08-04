import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fileview.dart';

class Addemployee extends StatefulWidget {
  const Addemployee({super.key});

  @override
  State<Addemployee> createState() => _AddemployeeState();
}

class _AddemployeeState extends State<Addemployee> {
   final user=FirebaseAuth.instance.currentUser! ; 
      DateTime date=DateTime.now();  
      FilePickerResult ?result;
String ?FileName;  
PlatformFile ?pickedfile;
File ? fileToDisplay ;
//  final _emailcontroller=TextEditingController();
    final _namecontroller=TextEditingController();
      final _descriptioncontroller=TextEditingController();
     DateTime e=DateTime.now(); bool isLoading=false ;

       // final _startcontroller=TextEditingController();
         final _foldercontroller=TextEditingController();

// ignore: non_constant_identifier_names
void pickfile() async
{
  try{
result=await FilePicker.platform.pickFiles( type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],allowMultiple: false);

if(result != null && result!.files.isNotEmpty) {FileName=result!.files.first.path;
pickedfile=result!.files.first;
fileToDisplay=File(pickedfile!.path.toString());
}

  } 
  
  catch(e) {print(e);}
}


Future Submit(String a,String b,String c,String d,)
async{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  await firestore.collection('employee').add(
  {
'name':a,
'description':b,

'path':c,
'folder':d,
  }
  );

}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
      
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)),color: Colors.white),
      child:   Column(children: [




      
      ListTile(textColor: Colors.pink,leading: IconButton(icon:const Icon(Icons.cancel),onPressed:() {
       Navigator.pop(context);}),title: const Text('Employee Files')),
            const Text('Email'),
      Text(user.email != null ? user.email! : 'not enregistred'),
      
      
      
      
      
      
       const SizedBox(height: 10,),
      
      
      
      const Text('Files'),
      
      
     
      
             Center(child: GestureDetector(onTap: () {
               pickfile();
             },child:Padding(
               padding: const EdgeInsets.only(right: 70,left: 70,top: 5,bottom:5),
               child: Container(color: Colors.black,child: const ListTile(iconColor: Colors.white,leading: Icon(Icons.attach_file),title:Text('Add attachmets',style: TextStyle(color: Colors.white),),)),
             ))),
     if (fileToDisplay != null)
  Row(
    children: [
      Text(fileToDisplay!.path),
  const     SizedBox(width: 10,),
      IconButton(onPressed:() {setState(() {
          FileName = null;
  pickedfile = null;
  fileToDisplay = null;
      });
        
      }, icon: Icon(Icons.delete))
    ],
  )
       else   
       const  SizedBox(),

            const SizedBox(height: 10,),

      const Text('File Name'),
      
      TextField(textAlign: TextAlign.center,autofocus: true,controller: _namecontroller,),
      
      const SizedBox(height: 10,),
      
      
      
      
      
     
              const Text('Description'),

     
      
      TextField(textAlign: TextAlign.center,autofocus: true,controller: _descriptioncontroller,),
      
      const SizedBox(height: 10,),
      
      const Text('Folder'),
      
     
      TextField(textAlign: TextAlign.center,autofocus: true,controller: _foldercontroller,),
      
      const SizedBox(height: 10,),
      
      ListTile(title: const Text('File view'),trailing: IconButton(onPressed: ()
      {
      setState(() {
        Navigator.pushNamed(context,'view' );
        
      });
      }
      , icon: const Icon(Icons.navigate_next)),),
   Text(Provider.of<fileview>(context).selected),
      
      
      
      Row(mainAxisAlignment: MainAxisAlignment.center,
        
        children:[

       Expanded(
         child: GestureDetector(
          onTap: (){Navigator.pop(context);},
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(padding: const EdgeInsets.all(20),
               decoration: BoxDecoration(borderRadius:BorderRadius.circular((12)),color: Colors.red,),
              child: const Center(child:  Text('cancel',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
          )),
             ),
       ),
        
      
    
      const SizedBox(width: 10,),
     isLoading ? const Center(child: CircularProgressIndicator())  :
       Expanded(
         child: GestureDetector(
          onTap: (){
           if (fileToDisplay != null) {
    setState(() {
      isLoading = true;
    });
    Submit(
      _namecontroller.text,
      _descriptioncontroller.text,
      
      fileToDisplay!.path,
      _foldercontroller.text
    ).then((value) {
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
    });
  } else {
    showDialog(context: context, builder:(context) {
      return const Center(child: AlertDialog(content: Text('An attachment is required!',style: TextStyle(color: Colors.red),),));},);
     
  }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(padding: const EdgeInsets.all(20),
               decoration: BoxDecoration(borderRadius:BorderRadius.circular((12)),color: Colors.green,),
              child: const Center(child:  Text('submit',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,),)),
          )),
             ),
       ),
      
      
      
      
      
       ] )
      
      
      
      
      
      
      
      
      
    ]),
      ),
    ) 

    
 ; }}
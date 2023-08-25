import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../task/valuecheckbox.dart';import 'package:http/http.dart' as http;import 'dart:convert';

class addquestion extends StatefulWidget {
  static const String screenroute='addquestions';
  const addquestion({super.key});

  @override
  State<addquestion> createState() => _addquestionState();
}

class _addquestionState extends State<addquestion> {
  final user=FirebaseAuth.instance.currentUser! ;   final GlobalKey<FormState> formkey = GlobalKey<FormState>();
      DateTime date=DateTime.now();  DateTime date1=DateTime.now();
      final _querycontroller=TextEditingController();
            final _descriptioncontroller=TextEditingController();
            Future<int> getDocumentCount() async {
    
  
     try {
      QuerySnapshot querySnapshot =await FirebaseFirestore.instance.collection('question').get();
      return querySnapshot.docs.length;
    } catch (error) {
    
      return 0;
    }
      
    
  }
                  FilePickerResult ?result;
String ?FileName;  
PlatformFile ?pickedfile;
File ? fileToDisplay ;
  
bool isLoading=false ;

        //  final _duecontroller=TextEditingController();

// ignore: non_constant_identifier_names
void pickfile() async
{
  try{
result=await FilePicker.platform.pickFiles( type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', ],allowMultiple: false);

if(result != null && result!.files.isNotEmpty) {FileName=result!.files.first.path;
pickedfile=result!.files.first;
fileToDisplay=File(pickedfile!.path.toString());
}

  } 
  
  catch(e) { showDialog(context: context, builder:(context){
      return AlertDialog(

content: Text(e.toString()),
      );    
         }
      
      );}
}
Future Submit(String a,String b,String c,String d)
async{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  await firestore.collection('question').add(
  {
'email':a,
'query':b,
'description':c,
'path':d,
  }
  );

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(centerTitle:true,title: const Text('Add Question',style: TextStyle(color: Colors.white,fontSize: 40),),backgroundColor: const Color.fromARGB(255, 223, 130, 161),
      leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.exit_to_app)),) ,
      body: SingleChildScrollView(
      
        child:   Form(key: formkey,
          child: Column(mainAxisAlignment: MainAxisAlignment.start,children: [
            
              ListTile(title: const Text('Priority'),trailing: IconButton(onPressed: ()
              {
              setState(() {
          Navigator.pushNamed(context,'priority' );
          
              });
              }
              , icon: const Icon(Icons.navigate_next)),),
              Text(Provider.of<check>(context).scale),
              
               
          
              const SizedBox(height: 10,),
          
          
          const Text('Query'),
          
          
          TextFormField(textAlign: TextAlign.center,autofocus: true,controller: _querycontroller,validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter query';
            }
            return null; 
          },),
          
          const SizedBox(height: 10,),
              
          
          
          const Text('Description'),
          
          TextField(textAlign: TextAlign.center,autofocus: true,controller: _descriptioncontroller,),
          
          const SizedBox(height: 10,),
              
          const Text('Attachment'),
                  const SizedBox(height: 10,),
        
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
          
          Padding(
            padding: const EdgeInsets.only(bottom: 10,top: 70),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              
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
                onTap: ()async{
                    if (fileToDisplay != null) {
            setState(() {
                isLoading = true;
            });
                 int count = await getDocumentCount();
         if ( formkey.currentState!.validate()){
            sendEmail(email: user.email??'', subject: _querycontroller.text, message: '$count');
            Submit(user.email ??'not entered',
                _querycontroller.text,
                _descriptioncontroller.text,
            
                fileToDisplay!.path,
            ).then((value) {
                setState(() {
            isLoading = false;
                });
                Navigator.pop(context);
            });} else {isLoading=false;}
                } else {
            showDialog(context: context, builder:(context) {
                return const Center(child: AlertDialog(content: Text('An attachment is required!',style: TextStyle(color: Colors.red),),));},);
             
                
                }},
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(padding: const EdgeInsets.all(20),
                     decoration: BoxDecoration(borderRadius:BorderRadius.circular((12)),color: Colors.green,),
                    child: const Center(child:  Text('submit',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,),)),
                )),
                   ),
             ),
            
            
            
            
            
            ]),
          )
          
          
          
          
          
          
          
          
          
              ]),
        ),
        ),
      
    ); }
    
    
    
    
    Future<void> sendEmail({
 // required String name,
  required String email,
  required String subject,
  required String message,
}) async {
  const serviceId = 'service_xlmxspm';
  const templateId = 'template_narj218';
  const userId = '3P6hA4_aGNRjDrWLl';

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
      //  'user_name': name,
        'user_email': email,
        'user_subject': subject,
        'user_message': message,
      },
    }),
  );


}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    }
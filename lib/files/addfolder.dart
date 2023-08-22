
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class addfolder extends StatefulWidget {
  const addfolder({super.key});

  @override
  State<addfolder> createState() => _addfolderState();
}

class _addfolderState extends State<addfolder> {
  final _foldercontroller=TextEditingController();
  Future Submit(String a)
async{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  await firestore.collection('foldernames').add(
  {
'name':a,

  }
  );

}

  @override
  Widget build(BuildContext context) {
    return Dialog(
child:Container(
    width: MediaQuery.of(context).size.width,
   decoration: const  BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0)),color: Colors.white) ,
   child:  Padding(padding: const EdgeInsets.all(12.0),
     child: SingleChildScrollView(
       child: Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
             
     
     const Text('Folder Name',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
  const   SizedBox(height: 5,),
     TextField(textAlign: TextAlign.center,decoration:const InputDecoration(hintText:'Enter Here') ,controller: _foldercontroller,),
     
    const  SizedBox(height: 10,),
     Center(
       child: Row(children: [
     Expanded(child: GestureDetector(onTap: () {
     
       Submit(_foldercontroller.text).then((value){Navigator.pop(context);});
     
     },child: Padding(
     
       padding: const EdgeInsets.all(12.0),
     
       child:   Container(padding: const EdgeInsets.all(8.0),child: const Text('OKAY',style: TextStyle(color: Colors.green),)),
     
     ))),
     Expanded(child: GestureDetector(onTap: () {
     
       Navigator.pop(context);
     
     },child: Padding(
     
       padding: const EdgeInsets.all(12.0),
     
       child:   Container(padding: const EdgeInsets.all(8.0),child: const Text('Cancel',style: TextStyle(color: Colors.red),)),
     
     )))
     
       ],),
     )
      
      
     
       ]),
     ),
   ),
   
   
   
   
   )




    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Addorganization extends StatefulWidget {
  const Addorganization({super.key});

  @override
  State<Addorganization> createState() => _AddorganizationState();
}

class _AddorganizationState extends State<Addorganization> {
   final user=FirebaseAuth.instance.currentUser! ; 
      DateTime date=DateTime.now();  

//  final _emailcontroller=TextEditingController();
    final _namecontroller=TextEditingController();
      final _descriptioncontroller=TextEditingController();
     DateTime e=DateTime.now(); bool isLoading=false ;

       // final _startcontroller=TextEditingController();
        //  final _duecontroller=TextEditingController();

// ignore: non_constant_identifier_names
Future Submit(String a,String b,DateTime c)
async{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  await firestore.collection('organization').add(
  {
'name':a,
'description':b,
'valid':c,


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
       Navigator.pop(context);}),title: const Text('Organization Files')),
      
      
      
      const Text('File Name'),
      
      TextField(textAlign: TextAlign.center,autofocus: true,controller: _namecontroller,),
      
      const SizedBox(height: 10,),
      
      
      
      
      
      const Text('Description'),
      
      TextField(textAlign: TextAlign.center,autofocus: true,controller: _descriptioncontroller,),
      
      const SizedBox(height: 10,),
      
      
      
      const Text('Valid Until'),
      
      Text('${date.day}/${date.month}/${date.year}'),
      
      ElevatedButton.icon(onPressed: ()async  { DateTime ? newDate =await     showDatePicker(
      
      context: context, initialDate: date, firstDate:DateTime(2000), lastDate: DateTime(2100));
      
      if (newDate==null) return;
      
      setState((){date=newDate;e=date;});
      
      }
      
      , icon:const Icon(Icons.calendar_today),label: const Text('SELECT',style: TextStyle(fontSize: 20),),),
      
      const SizedBox(height: 10,),
      
      
      ListTile(title: const Text('Folder'),trailing: IconButton(onPressed: ()
      {
      setState(() {
        Navigator.pushNamed(context,'folder' );
        
      });
      }
      , icon: const Icon(Icons.navigate_next)),),
   //   Text(Provider.of<check>(context).scale),
      
      
      
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
             setState(() { 
            isLoading=true ;
          });
          Submit(_namecontroller.text,_descriptioncontroller.text,e ).then((value){Navigator.pop(context);});
        },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(padding: const EdgeInsets.all(20),
               decoration: BoxDecoration(borderRadius:BorderRadius.circular((12)),color: Colors.green,),
              child: const Center(child:  Text('submit',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,),)),
          )),
             ),
       ),
      
      
      
      
      
      ])
      
      
      
      
      
      
      
      
      
    ]),
      ),
    ) 

    
 ; }}
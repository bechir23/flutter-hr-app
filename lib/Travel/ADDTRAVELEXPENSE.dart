import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Travel/traveldata.dart';
import 'package:provider/provider.dart';

class addtravelexpense extends StatefulWidget {
  const addtravelexpense({super.key});

  @override
  State<addtravelexpense> createState() => _addtravelexpenseState();
}

class _addtravelexpenseState extends State<addtravelexpense> {
  final user=FirebaseAuth.instance.currentUser! ; 
      DateTime date=DateTime.now();  bool isLoading=false ;

//  final _emailcontroller=TextEditingController();
    

 

        //  final _duecontroller=TextEditingController();

// ignore: non_constant_identifier_names
Future Submit(String a,DateTime d)
async{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  await firestore.collection('travelexpense').add(
  {
'email':a,
'time':d,

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
       Navigator.pop(context);}),title: const Text('Expense')),
      
      
      const Text('Travel ID'),
      
      Text(user.email != null ? user.email! : 'not enregistred')
      
      ,const SizedBox(height: 20,),
      
      
      
      
      
      
      
      
      
      
      ListTile(title: const Text('Travel ID'),trailing: IconButton(onPressed: ()
      {
      setState(() {
        Navigator.pushNamed(context,'choose');
        
      });
      }
      , icon: const Icon(Icons.navigate_next)),),
      const Text('place of visit',style:TextStyle(color: Colors.orange) ,),
      Text(Provider.of<traveldata>(context).text1),
         const    Text('purpose',style:TextStyle(color: Colors.orange) ,),

            Text(Provider.of<traveldata>(context).text2),

      
      
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
          Submit(user.email ?? 'not enregistred',date ).then((value){Navigator.pop(context);});
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
 
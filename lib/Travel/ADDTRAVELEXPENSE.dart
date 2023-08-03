
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Travel/detailsdata.dart';
import 'package:provider/provider.dart';

import 'choosetravel.dart';
class addtravelexpense extends StatefulWidget {
  const addtravelexpense({super.key});

  @override
  State<addtravelexpense> createState() => _addtravelexpenseState();
}

class _addtravelexpenseState extends State<addtravelexpense> {
  String  a='UNDIFINED';
  String b='UNDIFINED' ;
   void updateAAndB(String newA, String newB) {
    setState(() {
      a = newA;
      b = newB;
    });
  }
  final user=FirebaseAuth.instance.currentUser! ; 
      DateTime date=DateTime.now();  bool isLoading=false ;

//  final _emailcontroller=TextEditingController();
    

 

        //  final _duecontroller=TextEditingController();

// ignore: non_constant_identifier_names

Future clearCollection() async {
  CollectionReference collectionRef = FirebaseFirestore.instance.collection('SET');

  QuerySnapshot snapshot = await collectionRef.get();

  // Create a batch operation to delete all documents
  WriteBatch batch = FirebaseFirestore.instance.batch();
  for (var doc in snapshot.docs) {
    batch.delete(doc.reference);
  }

  // Commit the batch operation
  await batch.commit();
}

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)),color:  Color.fromARGB(255, 223, 130, 161),),
        child:   Column( crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, 
          children: [
        
        ListTile(textColor: Colors.pink,leading: IconButton(icon:const Icon(Icons.cancel),onPressed:() {
         Navigator.pop(context);}),title: const Text('Expense')),
        
        
        const Text('Email'),
        
        Text(user.email != null ? user.email! : 'not enregistred')
        
        ,const SizedBox(height: 20,),
        
            
        ListTile(title: const Text('Travel ID'),trailing: IconButton(  icon: const Icon(Icons.navigate_next),onPressed: b != null
      ? () {
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => choosetravel(
                 // a: a,
                 // b: b,
                   onAAndBChanged: updateAAndB,
                ),
              ),
            );
          });
        }
      : null,)),

        
        
        
        
        
        
        
    
    
        const Text('place of visit',style:TextStyle(color: Colors.orange) ,),
        Text(a),
           const    Text('purpose',style:TextStyle(color: Colors.orange) ,),
      
              Text(b),
      
        const SizedBox(height: 20,),
        GestureDetector(onTap: (){Navigator.pushNamed(context,'addexpense');}, child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(padding:const  EdgeInsets.all(12.0),
                 decoration: BoxDecoration(borderRadius:BorderRadius.circular((12)),color: const Color.fromARGB(255, 54, 82, 244),),child:const Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text('Expense'),SizedBox(width:20),Icon(Icons.add)],)),
        ),),
              const SizedBox(height: 20,),
      
         
        Flexible(//55214495
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                
            
              child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('SET').snapshots(),
              builder:(BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot )
              {
               if(snapshot.hasError) { return const Center(child: Text('No Trips found'));}
               if (snapshot.connectionState==ConnectionState.waiting)
               {return const Center(child: CircularProgressIndicator());}
                 
               return SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                 child: ListView(
                   children: snapshot.data!.docs.map((DocumentSnapshot document)
                   {Map<String,dynamic> data =document.data()! as Map<String,dynamic> ;
                   Provider.of<detailsdata>(context,listen: false).documents.add(data);
                      if (data['description'] == null) {
                     return const SizedBox(); // You can return an empty widget or handle this case as per your requirement.
                   }
                     return Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                         padding:const EdgeInsets.all(12.0),
                         decoration: const BoxDecoration(color: Color.fromARGB(255, 204, 101, 178),borderRadius: BorderRadius.all( Radius.circular(20))),
                         child:
                         
                         Row(
                           children: [Row(
                             children:[
                                       Text('${data['description']},',style: const TextStyle(color: Colors.white),),
                                       Text('${data['ticket']},',style: const TextStyle(color: Colors.white),),
                                       
                                       Text('${data['due']?.toDate().year}-${data['due']?.toDate().month.toString().padLeft(2, '0')}-${data['due']?.toDate().day.toString().padLeft(2, '0')} ${data['due']?.toDate().hour.toString().padLeft(2, '0')}:${data['due']?.toDate().minute.toString().padLeft(2, '0')}:${data['due']?.toDate().second.toString().padLeft(2, '0')}' ,style: const TextStyle(color: Colors.white),),
                                       Text('${data['lodging']},',style: const TextStyle(color: Colors.white),),
                                       Text(
                                        '${data['boarding']},',style: const TextStyle(color: Colors.white),),
                                       Text('${data['department']},',style: const TextStyle(color: Colors.white),),
                                       Text('${data['local']},',style: const TextStyle(color: Colors.white),),
                                       Text('${data['incidentals']},',style: const TextStyle(color: Colors.white),),
                                       Text('${data['others']},',style: const TextStyle(color: Colors.white),),
                                       Text('${data['phone']},',style: const TextStyle(color: Colors.white),),
                                       
                             ]
                        
                           ), 
                           const SizedBox(width: 20,),
                           
                           
                           IconButton(onPressed:(){FirebaseFirestore.instance.collection('SET').doc(document.id).delete();Provider.of<detailsdata>(context,listen: false).documents.remove(document.id);}, icon: const Icon(Icons.delete))
           ] )
                     
                       ),
                     );
                   }).toList(),
                           
                   
                 ),
               );
                // if(snapshot.hasData && snapshot.data!.docs.isNotEmpty) {               return Center(child: const Text('No tasks found'));
                
                    
                },
                
                
                ),
            ),
          ),
        ),
           Row(mainAxisAlignment: MainAxisAlignment.center,
         
         children:[
      
        Expanded(
          child: GestureDetector(
           onTap: (){Navigator.pop(context); Provider.of<detailsdata>(context,listen: false).init();clearCollection();},
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
           
           Submit(user.email ?? 'not enregistred',date ).then((value){Navigator.pop(context);
            }
           
           );
          Provider.of<detailsdata>(context,listen: false).init();
           },
           child: Padding(
             padding: const EdgeInsets.all(12.0),
             child: Container(padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(borderRadius:BorderRadius.circular((12)),color: Colors.green,),
               child: const Center(child:  Text('submit',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,),)),
           )),
              ),
        ),
        
        
        
        
        
        ]),
        ],
         )   ),
      )); 

    
  }}

































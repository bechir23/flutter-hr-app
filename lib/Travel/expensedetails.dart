import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detailsdata.dart';

class expensedetails extends StatelessWidget {
  static const screenroute='expensedetails';
  final  Map <String, dynamic>  m ;
  final String d;
  final List<Map <String, dynamic>> l;
  const expensedetails({super.key,required this.m,required this.d,required this.l});

  @override
  Widget build(BuildContext context) {
      final user=FirebaseAuth.instance.currentUser!;

 return Scaffold(

    appBar: AppBar(centerTitle: true,backgroundColor: const Color.fromARGB(255, 192, 109, 137),
   title: const Text('Details',style: TextStyle(color: Colors.white,fontSize: 40)),
  
   leading:Row(children: [
   
     
    
   Expanded(child: IconButton(onPressed: (){Navigator.pushNamed(context,'expense');}, icon: const Icon(Icons.exit_to_app_rounded))),
   const SizedBox(width: 30,),
   //email==d['email] ? .......:container 
      Expanded(
      child: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: SingleChildScrollView(
                  child: Container(
                              width: MediaQuery.of(context).size.width*0.5,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Are you sure you want to discard changes?',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                   FirebaseFirestore.instance.collection('travelexpense').doc(d).delete();
                                    Navigator.pushNamed(context, 'expense');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Text('Yes', style: TextStyle(color: Colors.green)),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: const Text('No', style: TextStyle(color: Colors.red)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        icon: const Icon(Icons.delete),
      ),
    )
 

   
   
   
   ]),


    ),
    body:Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
        children:[
             const Text('Email',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

            Text(user.email ?? 'not enregistred',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                                          const Text('Place of visit',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),
                    Text(m['place']??'-',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                                                          const Text('Purpose',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

        Text(m['purpose']??'-',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                                          const Text('Added Time',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),
                                       

            Text('${m['time']?.toDate().year}-${m['time']?.toDate().month.toString().padLeft(2, '0')}-${m['time']?.toDate().day.toString().padLeft(2, '0')} ${m['time']?.toDate().hour.toString().padLeft(2, '0')}:${m['time']?.toDate().minute.toString().padLeft(2, '0')}:${m['time']?.toDate().second.toString().padLeft(2, '0')}',style:const TextStyle(fontSize: 20,color: Colors.blue)),
                           
SingleChildScrollView(scrollDirection: Axis.horizontal,
  child:   DataTable(
  
        columns: const [
  
          DataColumn(label: Text('DESCRIPTION',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
  
                  DataColumn(label: Text('DATE',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
  
          DataColumn(label: Text('TICKET',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
  
          DataColumn(label: Text('LODGING',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
  
          DataColumn(label: Text('BOARDING',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
  
                 DataColumn(label: Text('PHONE',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
  
  
  
          DataColumn(label: Text('LOCAL CONVEYANCE',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
  
          DataColumn(label: Text('INCIDENTALS',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
  
          DataColumn(label: Text('OTHERS',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
  
  
  
  
        ],
  
        rows: List.generate(Provider.of<detailsdata>(context,listen: false).documents.length, (index) {
  
          return 
  
           DataRow(
  
            cells: [
  
              DataCell(Text(l[index]['description']??'-')),
  
                          DataCell(Text('${l[index]['date']?.toDate().year}-${l[index]['date']?.toDate().month.toString().padLeft(2, '0')}-${l[index]['date']?.toDate().day.toString().padLeft(2, '0')} ${l[index]['date']?.toDate().hour.toString().padLeft(2, '0')}:${l[index]['date']?.toDate().minute.toString().padLeft(2, '0')}:${l[index]['date']?.toDate().second.toString().padLeft(2, '0')}')),
  
              DataCell(Text(l[index]['ticket']??'-')),
  
                          DataCell(Text(l[index]['lodging']??'-')),
  
              DataCell(Text(l[index]['boarding']??'-')),
  
              DataCell(Text(l[index]['phone'].toString())),
  
              DataCell(Text(l[index]['local']??'-')),
  
                          DataCell(Text(l[index]['incidentals']??'-')), 
  
                                     DataCell(Text(l[index]['others']??'-')),
  
  
  
  
  
  
  
  
  
            
  
  
            ],
  
          );
  
        }),
  
      ),
)



        ]


      
      
      ),
    ),



    );
  }
}
 
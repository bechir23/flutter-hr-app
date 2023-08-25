import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/compensation/medical.dart';
import 'package:provider/provider.dart';

class benefitdetails extends StatelessWidget {
 final  Map <String, dynamic>  m ;
  final String d;
 final  List<Map <String, dynamic>> l;
  const benefitdetails({super.key,required this.m,required this.d,required this.l});

  @override
  Widget build(BuildContext context) {
      final user=FirebaseAuth.instance.currentUser!;

 return Scaffold(

    appBar: AppBar(centerTitle: true,backgroundColor: const Color.fromARGB(255, 192, 109, 137),
   title: const Text('Details',style: TextStyle(color: Colors.white,fontSize: 40)),
  
   leading:Row(children: [
   
     
    
   Expanded(child: IconButton(onPressed: (){ Navigator.pushNamed(context, 'benefit');}, icon: const Icon(Icons.exit_to_app_rounded))),
   const SizedBox(width: 40,),
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
FirebaseFirestore.instance.collection('tabbenefit').doc(d).delete();                                    Navigator.pushNamed(context, 'benefit');
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
    ),
     

   
   
   
   ]),



    ),
    body:Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
        children:[
             const Text('Email',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

            Text(user.email ?? 'not enregistred',style:const TextStyle(fontSize: 20,color: Colors.blue),),
              const Text('Education Allowance',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

            Text(m['education'] ?? 'not enregistred',style:const TextStyle(fontSize: 20,color: Colors.blue),),  const Text('Lunch',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

            Text(m['lunch'] ?? 'not enregistred',style:const TextStyle(fontSize: 20,color: Colors.blue),),  const Text('Housing Allowance',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

            Text(m['housing'] ?? 'not enregistred',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                
                               const Text('Currency',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),
                 Text(m['currency'] ?? 'not enregistred',style:const TextStyle(fontSize: 20,color: Colors.blue),),

const SizedBox(height: 10,),
                           
SingleChildScrollView(scrollDirection: Axis.horizontal,
  child:   DataTable(
  
        columns: const [
  
          DataColumn(label: Text('SCHEME',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
  
                  DataColumn(label: Text('CATEGORY',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
  
          DataColumn(label: Text('COST',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
  
          DataColumn(label: Text('MEMBER',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
  
          DataColumn(label: Text('MEMBERSHIP NUMBER',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
  
                
        ],
  
        rows: List.generate(Provider.of<medicaldata>(context,listen: false).documents.length, (index) {
  
          return 
  
           DataRow(
  
            cells: [
  
              DataCell(Text(l[index]['scheme']??'-')),
  
                        
  
              DataCell(Text(l[index]['category']??'-')),
  
                          DataCell(Text((l[index]['cost']).toString())),
  
              DataCell(Text(l[index]['member']??'-')),
  
              DataCell(Text((l[index]['number']).toString())),
  
          
  
  
  
  
  
  
  
  
            
  
  
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
 
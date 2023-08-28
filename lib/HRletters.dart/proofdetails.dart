import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class proofdetails extends StatelessWidget {
  static const String screenroute='proofdetails';
 
 final  Map <String, dynamic>  m ;
   final String  d  ;
    
   const proofdetails({super.key, required this.m, required this.d} ); 
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: AppBar(centerTitle: true,backgroundColor: const Color.fromARGB(255, 192, 109, 137),
   title: const Text('Details',style: TextStyle(color: Colors.white,fontSize: 40)),
   actions: [    Expanded(
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
                                   FirebaseFirestore.instance.collection('addressproof').doc(d).delete();
                                    Navigator.pushNamed(context, 'proof');
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
    )],
   leading:
   
     
    
   IconButton(onPressed: (){Navigator.pushNamed(context,'proof');}, icon: const Icon(Icons.exit_to_app_rounded)),
  
   //email==d['email] ? .......:container 
     
   
   
   
   



    ),
    body:Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
        children:[
             const Text('email',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

            Text(m['email'] ?? 'not enregistred',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                                       
                                  
                                          const Text('Date of request',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

        Text('${m['request']?.toDate().year}-${m['request']?.toDate().month.toString().padLeft(2, '0')}-${m['request']?.toDate().day.toString().padLeft(2, '0')} ${m['request']?.toDate().hour.toString().padLeft(2, '0')}:${m['request']?.toDate().minute.toString().padLeft(2, '0')}:${m['request']?.toDate().second.toString().padLeft(2, '0')}',style:const TextStyle(fontSize: 20,color: Colors.blue)),
                                          
                                                        const Text('Is there any change in present Address',style: TextStyle(fontSize: 20,color: Colors.black,fontStyle: FontStyle.italic)),
            Text(m['yesno'] ?? 'not enregistred',style:const TextStyle(fontSize: 20,color: Colors.blue),),

                                           const Text('Reason for request',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

                              Text(m['reason']?? 'No email available',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                            
        ]


      
      
      ),
    ),



    );
  }
}
 
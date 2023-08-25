import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class traveldetails extends StatelessWidget {
  static const String screenroute='traveldetails';
  final  Map <String, dynamic>  m ;
   final String  d  ;
   
   const traveldetails({super.key, required this.m, required this.d} ); 
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: AppBar(centerTitle: true,backgroundColor: const Color.fromARGB(255, 192, 109, 137),
   title: const Text('Details',style: TextStyle(color: Colors.white,fontSize: 40)),
  
   leading:Row(children: [
   
     
    
   Expanded(child: IconButton(onPressed: (){   Navigator.pushNamed(context, 'request');}, icon: const Icon(Icons.exit_to_app_rounded))),
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
                                   FirebaseFirestore.instance.collection('travelrequest').doc(d).delete();
                                    Navigator.pushNamed(context, 'request');
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
             const Text('email',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

            Text(m['email'] ?? 'not enregistred',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                                          const Text('department',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

                              Text(m['department']?? 'No email available',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                                                          const Text('place',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

              Text(m['place']?? 'No email available',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                                          const Text('arrival',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),
                                       

            Text('${m['arrival']?.toDate().year}-${m['arrival']?.toDate().month.toString().padLeft(2, '0')}-${m['arrival']?.toDate().day.toString().padLeft(2, '0')} ${m['arrival']?.toDate().hour.toString().padLeft(2, '0')}:${m['arrival']?.toDate().minute.toString().padLeft(2, '0')}:${m['arrival']?.toDate().second.toString().padLeft(2, '0')}',style:const TextStyle(fontSize: 20,color: Colors.blue)),
                                          const Text('deperature',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

        Text('${m['deperature']?.toDate().year}-${m['deperature']?.toDate().month.toString().padLeft(2, '0')}-${m['deperature']?.toDate().day.toString().padLeft(2, '0')} ${m['deperature']?.toDate().hour.toString().padLeft(2, '0')}:${m['deperature']?.toDate().minute.toString().padLeft(2, '0')}:${m['deperature']?.toDate().second.toString().padLeft(2, '0')}',style:const TextStyle(fontSize: 20,color: Colors.blue)),
                                          const Text('purpose',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

      Text(m['purpose']?? 'No email available',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                                                 const Text('duration',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),
      Text(m['duration']?? 'No email available',style:const TextStyle(fontSize: 20,color: Colors.blue),),
       
       
        ]


      
      
      ),
    ),



    );
  }
}
 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class exitdetails extends StatelessWidget {
  static const  String screenroute='exitdetails';

 final  Map <String, dynamic>  m ;
   final String  d  ;
    
   const exitdetails({super.key, required this.m, required this.d} ); 
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: AppBar(centerTitle: true,backgroundColor: const Color.fromARGB(255, 192, 109, 137),
   title: const Text('Exit Details',style: TextStyle(color: Colors.white,fontSize: 40)),
  
   leading:Row(
  children: [
    Expanded(
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.exit_to_app),
      ),
    ),
    const SizedBox(width: 30),
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
                                    FirebaseFirestore.instance.collection('exit').doc(d).delete();
                                    Navigator.pushNamed(context, 'exit');
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
  ],
),



    ),
    body:Padding(
      padding: const EdgeInsets.all(20.0),



      child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
        children:[
             const Text('email',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

            Text(m['email'] ?? 'Not found',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                             
                                           
                                          const Text('Separation Date',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),
                                       

            Text('${m['separationdate']?.toDate().year}-${m['separationdate']?.toDate().month.toString().padLeft(2, '0')}-${m['separationdate']?.toDate().day.toString().padLeft(2, '0')} ${m['separationdate']?.toDate().hour.toString().padLeft(2, '0')}:${m['separationdate']?.toDate().minute.toString().padLeft(2, '0')}:${m['separationdate']?.toDate().second.toString().padLeft(2, '0')}',style:const TextStyle(fontSize: 20,color: Colors.blue)),
                                         const Text('Reason for leaving',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

                              Text(m['reason']?? 'Not found',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                                          const Text('Company vehicule handed in',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

              Text(m['vehicule']?? 'Not found',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                      const Text('All books submitted',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

              Text(m['books']?? 'Not found',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                      const Text('Exit interview conducted in',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

              Text(m['interview']?? 'Not found',style:const TextStyle(fontSize: 20,color: Colors.blue),),        const Text('Company vehicule handed in',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),
 Text(m['vehicule']?? 'Not found',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                const Text('Resignation letter submitted',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

              Text(m['resignation']?? 'Not found',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                      const Text('All equipments handed in',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

              Text(m['equipments']?? 'Not found',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                      const Text('Security',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

              Text(m['security']?? 'Not found',style:const TextStyle(fontSize: 20,color: Colors.blue),),     
        const Text('Notice period followed',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

              Text(m['notice']?? 'Not found',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                      // ignore: unnecessary_string_escapes
                      const Text('Manger/Supervisor cleareance',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

              Text(m['manager']?? 'Not found',style:const TextStyle(fontSize: 20,color: Colors.blue),),
        ]


      
      
      ),
    ),



    );
  }
}
 
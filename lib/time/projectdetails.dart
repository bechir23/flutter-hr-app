import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class projectdetails extends StatefulWidget {
  final  Map <String, dynamic>  m ;
   final String  d  ;
    
   const projectdetails({super.key, required this.m, required this.d} ); 

  @override
  State<projectdetails> createState() => _projectdetailsState();
}

class _projectdetailsState extends State<projectdetails> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(

    appBar: AppBar(centerTitle: true,backgroundColor: const Color.fromARGB(255, 192, 109, 137),
   title: const Text('Details',style: TextStyle(color: Colors.white,fontSize: 40)),
  
   leading:Row(children: [
   
     
    
   Expanded(child: IconButton(onPressed: (){Navigator.pushNamed(context,'project');}, icon: const Icon(Icons.exit_to_app_rounded))),
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
FirebaseFirestore.instance.collection('project').doc(widget.d).delete();Navigator.pushNamed(context, 'project');
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
             const Text('Project Name',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

            Text(widget.m['name'] ?? 'not enregistred',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                                          const Text('Client Name',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

                              Text(widget.m['client']?? 'No email available',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                              const Text('Project Cost',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

                              Text(widget.m['cost'].toString(),style:const TextStyle(fontSize: 20,color: Colors.blue),),

                                        const Text('Project Head',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),
                                Text(widget.m['head']?? 'No email available',style:const TextStyle(fontSize: 20,color: Colors.blue),),         
        
            const Text('Project Manager',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),
                                Text(widget.m['manager']?? 'No email available',style:const TextStyle(fontSize: 20,color: Colors.blue),),         
           const Text('Project User',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),
                                Text(widget.m['user']?? 'No email available',style:const TextStyle(fontSize: 20,color: Colors.blue),),         
       
      
      
        ]


      
      
      ),
    ),



    );
  }
 
}
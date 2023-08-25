import 'package:flutter/material.dart';
class colldetails extends StatelessWidget {
 final Map<String,dynamic> m;
  const colldetails({super.key, required this.m});

  @override
  Widget build(BuildContext context) {
  

 
    return Scaffold(

    appBar: AppBar(centerTitle: true,backgroundColor: const Color.fromARGB(255, 192, 109, 137),
   title: const Text('Collegue Infos',style: TextStyle(color: Colors.white,fontSize: 40)),
  
   leading:IconButton(onPressed: (){
     Navigator.pop(context);}, icon: const Icon(Icons.exit_to_app)),



    ),
    body:Padding(
      padding: const EdgeInsets.all(20.0),



      child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
        children:[
             const Text('Email',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

            Text(m['email'] ?? 'Not found',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                                  const Text('Organization',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

              Text(m['organization']?? 'Not found',style:const TextStyle(fontSize: 20,color: Colors.blue),),
                           
                                         const Text('Industry',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

              Text(m['industry']?? 'Not found',style:const TextStyle(fontSize: 20,color: Colors.blue),),

                                         const Text('Phone',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),

              Text(m['phone'].toString(),style:const TextStyle(fontSize: 20,color: Colors.blue),),

                                         const Text('Date of Joining',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),
            Text('${m['date']?.toDate().year}-${m['date']?.toDate().month.toString().padLeft(2, '0')}-${m['date']?.toDate().day.toString().padLeft(2, '0')} ',style:const TextStyle(fontSize: 20,color: Colors.blue)),
                                         const Text('Designation',style:TextStyle(fontSize: 20,color:Colors.black,fontStyle: FontStyle.italic),),
              Text(m['designation']?? 'Not found',style:const TextStyle(fontSize: 20,color: Colors.blue),),








  ])));}}

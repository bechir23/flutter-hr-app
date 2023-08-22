import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Travel/ADDTRAVELREQUEST.dart';
import 'package:myapp/Travel/traveldetails.dart';

class travelrequest extends StatefulWidget {
    static const String screenroute='request'; 
    

  const travelrequest({super.key});

  @override
  State<travelrequest> createState() => _travelrequestState();
}

class _travelrequestState extends State<travelrequest> {
  int i=1;final GlobalKey<State> _key = GlobalKey<State>();
  
  Future<int> getDocumentCount() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot snapshot = await firestore.collection('travelrequest').get();
  int documentCount = snapshot.size;
  return documentCount;
}
Future update() async{int j=await getDocumentCount();
setState(() {
  i=j;
}); }
  @override
 
  Widget build(BuildContext context) {
    return Scaffold( key: _key,
         body:
         
         
         
         StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('travelrequest').orderBy('time').snapshots(),
      builder:(BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot )
      {
        if(snapshot.hasError) { return const Center(child: Text('No Trips found'));}
        if (snapshot.connectionState==ConnectionState.waiting)
        {return const Center(child: CircularProgressIndicator());}
     
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document)
          {Map<String,dynamic> data =document.data()! as Map<String,dynamic> ;
             if (data['email'] == null) {
      return const SizedBox(); // You can return an empty widget or handle this case as per your requirement.
    }
            return TextButton(
              onPressed: () {
                Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => traveldetails(m: data, d: document.id),
              ),
            
          
          );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding:const EdgeInsets.all(12.0),
                  decoration: const BoxDecoration(color: Color.fromARGB(255, 204, 101, 178),borderRadius: BorderRadius.all( Radius.circular(20))),
                  child: ListTile(
                    leading: CircleAvatar(backgroundColor: Colors.white,child: Text(data['email'].toString().substring(0,2).toUpperCase(),style: const TextStyle(color: Colors.blue),),),
                    // ignore: dead_code
                    title: Text(data['department']??'',style: const TextStyle(color: Colors.white),),
                    subtitle: Text(data['email']??'',style: const TextStyle(color: Colors.white),),
                  ),
                ),
              ),
            );
          }).toList(),
                  
    
        );
    // if(snapshot.hasData && snapshot.data!.docs.isNotEmpty) {               return Center(child: const Text('No tasks found'));
    
             
    },
    
    
    ),


        
      
      appBar: AppBar(centerTitle:true,title: const Text('Travel Request',style: TextStyle(color: Colors.white,fontSize: 40),),backgroundColor: const Color.fromARGB(255, 223, 130, 161),leading: IconButton(icon: const Icon(Icons.exit_to_app),onPressed: () {Navigator.pushNamed(context,'travel');
        
      },),),
      
      backgroundColor: const Color.fromARGB(255, 223, 130, 161),
  


      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await update();
          print(i);

          showModalBottomSheet(
            isScrollControlled: true,
            context: _key.currentContext!,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: FutureBuilder(
                  future: update(), 
                  builder: (context, snapshot) {
                //    if (snapshot.connectionState == ConnectionState.waiting) {
                  //    return const  CircularProgressIndicator(); 
                   // }

                    return addtravelrequest(i: i);
                  },
                ),
              ),
            ),
          );
        },  backgroundColor:Colors.white,
      child: const Icon(Icons.add,color: Colors.pink,),),

    )
    
      
    ;
  }
}

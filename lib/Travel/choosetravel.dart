import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Travel/detailsdata.dart';
import 'package:provider/provider.dart';

import '../models/traveldata.dart';


class choosetravel extends StatefulWidget {
 static const String screenroute='choose';
    //String a;
    //String  b;
    final void Function(String newA, String newB)? onAAndBChanged;
 const choosetravel({super.key,required this.onAAndBChanged});
  
  

  @override
  State<choosetravel> createState() => _choosetravelState();
}

class _choosetravelState extends State<choosetravel> {
  
 // late String _a;
  //late String _b;

 // @override
  //void initState() {
   // super.initState();
    //_a = widget.a; // Initialize private variable with the provided value
   // _b = widget.b; // Initialize private variable with the provided value
  //}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 114, 152),
        leading: IconButton(icon: const Icon(Icons.exit_to_app),onPressed: ()  {  Navigator.pop(context);
   // Provider.of<traveldata>(context,listen: false).update() ;
          
        
      },),title: const Text('Travel ID',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 40),),),
        backgroundColor: const Color.fromARGB(255, 240, 128, 165),
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('travelrequest').snapshots(),
      builder:(BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot )
      {
        if(snapshot.hasError) { return const Center(child: Text('No tasks found'));}
        if (snapshot.connectionState==ConnectionState.waiting)
        {return const Center(child: CircularProgressIndicator());}
     
     return ListView.builder(
  itemCount: snapshot.data!.docs.length,
  itemBuilder: (context, index) {
    DocumentSnapshot document = snapshot.data!.docs[index];
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (data['travelid'] == null) {
      return const SizedBox();
    }
    final travelData = Provider.of<traveldata>(context);
    final currentIndex = index;
 final bool isChecked = travelData.values.isNotEmpty && index >= 0 && index < travelData.values.length && travelData.values[index];
    return ListTile(
      title: Text('TravelID${data['travelid']}'),
      trailing: Checkbox(
        value: isChecked
           ,
        onChanged: (value) {
          setState(() {
       
        if (value!) {
              travelData.selectedIdx = index;
              travelData.values = List.generate(snapshot.data!.docs.length, (i) => i == index);
                 if (widget.onAAndBChanged != null) {
      widget.onAAndBChanged!(data['purpose'], data['place']);Provider.of<detailsdata>(context,listen:false).a=data['purpose'];Provider.of<detailsdata>(context,listen:false).b=data['place'];}
         } else {
             
              travelData.selectedIdx = -1;
              travelData.values = List.generate(snapshot.data!.docs.length, (i) => false);}

          });
        },
      ),
    );
  },
);






        
    // if(snapshot.hasData && snapshot.data!.docs.isNotEmpty) {               return Center(child: const Text('No tasks found'));
    
             
    },
    
    
    ));}}
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
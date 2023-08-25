import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/time/projectdata.dart';
import 'package:provider/provider.dart';


class projectview extends StatefulWidget {
  static const String screenroute='projectview';
  const projectview({super.key});

  @override
  State<projectview> createState() => _projectviewState();
}

class _projectviewState extends State<projectview> {
  @override
  Widget build(BuildContext context) {
 return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 114, 152),
        leading: IconButton(icon: const Icon(Icons.exit_to_app),onPressed: ()  {  Navigator.pop(context);
   // Provider.of<traveldata>(context,listen: false).update() ;
          
        
      },),title: const Text('Project',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 40),),),
        backgroundColor: const Color.fromARGB(255, 240, 128, 165),
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('project').snapshots(),
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
    if (data['name'] == null) {
      return const SizedBox();
    }
        final projectData = Provider.of<projectdata>(context);

    
 final bool isChecked = projectData.values.isNotEmpty && index >= 0 && index < projectData.values.length && projectData.values[index];
    return ListTile(
      title: Text(data['name']),
      trailing: Checkbox(
        value: isChecked
           ,
        onChanged: (value) {
          setState(() {
       
        if (value!) {
              projectData.selectedIdx = index;
              projectData.selected=data['name'];
              projectData.values = List.generate(snapshot.data!.docs.length, (i) => i == index);
               
         } else {
             
              projectData.selectedIdx = -1;
              projectData.values = List.generate(snapshot.data!.docs.length, (i) => false);}

          });
        },
      ),
    );
  },
);






        
    // if(snapshot.hasData && snapshot.data!.docs.isNotEmpty) {               return Center(child: const Text('No tasks found'));
    
             
    },
    
    
    ));}}
        
        
        
        
        
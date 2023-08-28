import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/time/projectdata.dart';
import 'package:provider/provider.dart';

class assigneesview extends StatefulWidget {
 final int i;
  const assigneesview({super.key,required this.i});

  @override
  State<assigneesview> createState() => _assigneesviewState();
}

class _assigneesviewState extends State<assigneesview> {
  @override
  Widget build(BuildContext context) {
return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 114, 152),
        leading: IconButton(icon: const Icon(Icons.exit_to_app),onPressed: ()  {  Navigator.pop(context);
   // Provider.of<traveldata>(context,listen: false).update() ;
          
        
      },),title: const Text('Assignees',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 40),),),
        backgroundColor: const Color.fromARGB(255, 240, 128, 165),
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('colleague').snapshots(),
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
    if (data['email'] == null) {
      return const SizedBox();
    }
        final projectData = Provider.of<projectdata>(context);

    final email = data['email'] ?? '';
 final bool isChecked = projectData.values.isNotEmpty && index >= 0 && index < projectData.values.length && projectData.values[index];
    return ListTile(
      title: Text(email),
      trailing: Checkbox(
        value: isChecked
           ,
        onChanged: (value) {
          setState(() {
       
        if (value!) {
              projectData.selectedIdx = index;
              projectData.updateSelected(widget.i, email);

                    
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
        
        
        
        
        
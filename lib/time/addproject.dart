
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/time/assigneesview.dart';
import 'package:myapp/time/projectdata.dart';
import 'package:provider/provider.dart';

class addproject extends StatefulWidget {
  static const String screenroute='addproject';
  const addproject({super.key});

  @override
  State<addproject> createState() => _addprojectState();
}

class _addprojectState extends State<addproject> {
   DateTime date=DateTime.now();        DateTime date1=DateTime.now();       
      DateTime f=DateTime.now();  


   
//  final _emailcontroller=TextEditingController();
    final _namecontroller=TextEditingController();
      final _descriptioncontroller=TextEditingController();
     DateTime e=DateTime.now(); bool isLoading=false ;
   final GlobalKey<FormState> formkey = GlobalKey<FormState>();

       // final _startcontroller=TextEditingController();
         final _ratecontroller=TextEditingController();

// ignore: non_constant_identifier_names



Future Submit(String a,String b,int c,String f,String g,String h,String i)
async{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  await firestore.collection('project').add(
  {
'name':a,
'client':b,
'cost':c,
'head':f,
'manager':g,
'user':h,
'description':i
  }
  );

}

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar:  AppBar(centerTitle:true,title: const Text('Add Project',style: TextStyle(color: Colors.white,fontSize: 40),),backgroundColor: const Color.fromARGB(255, 223, 130, 161),
      leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.exit_to_app)),) ,
      body: SingleChildScrollView(
        child: Container(
        
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)),color: Colors.white),
        child:   Form(key: formkey,
          child: Column(children: [
        
    
                const Text('Project Name'),
            TextFormField(textAlign: TextAlign.center,autofocus: true,controller: _namecontroller,validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter project name';
              }
              return null; }),
          
          
          
          
          
           const SizedBox(height: 10,),
           Consumer<projectdata>(
  builder: (context, projectData, _) {
    return Column(
      children: [
        ListTile(
          title: const Text('Client'),
          trailing: IconButton(
            onPressed: () {
                Navigator.pushNamed(context,'clientview');
            },
            icon: const Icon(Icons.navigate_next),
          ),
        ),
        Text('Selected: ${projectData.selected[3]}'),
      ],
    );
  },
),
          
         
           
                  const SizedBox(height: 10,),

          const Text('description'),
          
             
          TextField(textAlign: TextAlign.center,autofocus: true,controller: _descriptioncontroller,),
          
          const SizedBox(height: 10,),
          
          
          const Text('Project cost'),
          
             
          TextField(textAlign: TextAlign.center,autofocus: true,controller: _ratecontroller,inputFormatters: [FilteringTextInputFormatter.digitsOnly],),
          
          const SizedBox(height: 10,),
 Consumer<projectdata>(
  builder: (context, projectData, _) {
    return Column(
      children: [
        ListTile(
          title: const Text('Assign Head'),
          trailing: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const assigneesview(i: 0),
                ),
              );
            },
            icon: const Icon(Icons.navigate_next),
          ),
        ),
        Text('Selected: ${projectData.selected[0]}'),
      ],
    );
  },
),

        
          
                          const SizedBox(height: 10,),
                          Consumer<projectdata>(
  builder: (context, projectData, _) {
    return Column(
      children: [
        ListTile(
          title: const Text('Assign Manager'),
          trailing: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const assigneesview(i: 1),
                ),
              );
            },
            icon: const Icon(Icons.navigate_next),
          ),
        ),
        Text('Selected: ${projectData.selected[1]}'),
      ],
    );
  },
),

        
      
                                    const SizedBox(height: 10,),
Consumer<projectdata>(
  builder: (context, projectData, _) {
    return Column(
      children: [
        ListTile(
          title: const Text('Assign User'),
          trailing: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const assigneesview(i: 2),
                ),
              );
            },
            icon: const Icon(Icons.navigate_next),
          ),
        ),
        Text('Selected: ${projectData.selected[2]}'),
      ],
    );
  },
),

        

          
          
          Row(mainAxisAlignment: MainAxisAlignment.center,
            
            children:[
        
           Expanded(
             child: GestureDetector(
              onTap: (){Navigator.pop(context);},
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(padding: const EdgeInsets.all(20),
                   decoration: BoxDecoration(borderRadius:BorderRadius.circular((12)),color: Colors.red,),
                  child: const Center(child:  Text('cancel',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)),
              )),
                 ),
           ),
            
          
            
          const SizedBox(width: 10,),
             isLoading ? const Center(child: CircularProgressIndicator())  :
           Expanded(
             child: GestureDetector(
              onTap: (){
            
              if ( formkey.currentState!.validate()){
          try{ Submit(
          _namecontroller.text,
         Provider.of<projectdata>(context,listen: false).selected[3],int.parse(_ratecontroller.text),
          Provider.of<projectdata>(context,listen: false).selected[0],
        Provider.of<projectdata>(context,listen: false).selected[1]  ,Provider.of<projectdata>(context,listen: false).selected[2]
        ,
           _descriptioncontroller.text,  ).then((value) {
          setState(() {
            isLoading = false;
          });
          Navigator.pop(context);
            });}
          catch(e){showDialog(context: context, builder:(context) {
          return const Center(child: AlertDialog(content: Text('Cost is required!',style: TextStyle(color: Colors.red),),));},);
            }
          }
            else {isLoading=false;} 
            
               
          
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(padding: const EdgeInsets.all(20),
                   decoration: BoxDecoration(borderRadius:BorderRadius.circular((12)),color: Colors.green,),
                  child: const Center(child:  Text('submit',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,),)),
              )),
                 ),
           ),
          
          
          
          
          
           ] )
          
          
          
          
          
          
          
          
          
            ]),
        ),
        ),
      ),
    ) 

    
 ; }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/task/valuecheckbox.dart';
import 'package:provider/provider.dart';import 'package:http/http.dart' as http;import 'dart:convert';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final user=FirebaseAuth.instance.currentUser! ; 
      DateTime date=DateTime.now();  DateTime date1=DateTime.now();

//  final _emailcontroller=TextEditingController();
    final _taskcontroller=TextEditingController();
      final _descriptioncontroller=TextEditingController();
     DateTime e=DateTime.now(); DateTime f=DateTime.now();bool isLoading=false ;

       // final _startcontroller=TextEditingController();
        //  final _duecontroller=TextEditingController();

// ignore: non_constant_identifier_names
Future Submit(String a,String b,String c,DateTime d,DateTime e,DateTime f,String g)
async{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  await firestore.collection('post').add(
  {
'email':a,
'task':b,
'description':c,
'time':d,
'start':e,
'due':f,
'priority':g

  }
  );

}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
      
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)),color: Colors.white),
      child:   Form(key: formkey,
        child: Column(children: [
        
        ListTile(textColor: Colors.pink,leading: IconButton(icon:const Icon(Icons.cancel),onPressed:() {Provider.of<check>(context,listen: false).scale='low';Provider.of<check>(context,listen: false).init();
         Navigator.pop(context);}),title: const Text('Task')),
        
        
        const Text('Task Owner'),
        
        Text(user.email != null ? user.email! : 'not enregistred')
        
        ,const SizedBox(height: 20,),
        
        
        
        
        
        const Text('Task Name'),
        
        TextFormField(textAlign: TextAlign.center,autofocus: true,controller: _taskcontroller,validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the task name';
            }
            return null; 
          
        },),
        
        const SizedBox(height: 20,),
        
        
        
        
        
        const Text('Description'),
        
        TextField(textAlign: TextAlign.center,autofocus: true,controller: _descriptioncontroller,),
        
        const SizedBox(height: 20,),
        
        
        
        const Text('Start Date'),
        
        Text('${date.day}/${date.month}/${date.year}'),
        
        ElevatedButton.icon(onPressed: ()async  { DateTime ? newDate =await     showDatePicker(
        
        context: context, initialDate: date, firstDate:DateTime(2000), lastDate: DateTime(2100));
        
        if (newDate==null) return;
        
        setState((){date=newDate;e=date;});
        
        }
        
        , icon:const Icon(Icons.calendar_today),label: const Text('To Start',style: TextStyle(fontSize: 20),),),
        
        const SizedBox(height: 20,),
        
        const Text('Due Date'),
        
        Text('${date1.day}/${date1.month}/${date1.year}'),
        
        ElevatedButton.icon(onPressed: ()async  { DateTime ? newDate1 =await     showDatePicker(
        
        context: context, initialDate: date, firstDate:DateTime(2000), lastDate: DateTime(2100));
        
        if (newDate1==null) return;
        
        setState((){date1=newDate1;f=date1;});
        
        }
        
        , icon:const Icon(Icons.calendar_today),label: const Text('Due Date',style: TextStyle(fontSize: 20),),),
        const SizedBox(height: 20,),
        
        ListTile(title: const Text('Priority'),trailing: IconButton(onPressed: ()
        {
        setState(() {
          Navigator.pushNamed(context,'priority' );
          
        });
        }
        , icon: const Icon(Icons.navigate_next)),),
        Text(Provider.of<check>(context).scale),
        
        
        
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
               setState(() { 
              isLoading=true ;
            });
             if (formkey.currentState!.validate()){
            sendEmail( email: user.email!, subject: _taskcontroller.text,);
            Submit(user.email ?? 'not enregistred',_taskcontroller.text,_descriptioncontroller.text,date,e,f,Provider.of<check>(context,listen: false).scale ).then((value){Navigator.pop(context);});
             } else {isLoading=false;}},
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(padding: const EdgeInsets.all(20),
                 decoration: BoxDecoration(borderRadius:BorderRadius.circular((12)),color: Colors.green,),
                child: const Center(child:  Text('submit',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white,),)),
            )),
               ),
         ),
        
        
        
        
        
        ])
        
        
        
        
        
        
        
        
        
          ]),
      ),
      ),
    ) 

    
 ; }


Future<void> sendEmail({
 // required String name,
  required String email,
  required String subject,
//  required String message,
}) async {
  const serviceId = 'service_xlmxspm';
  const templateId = 'template_j0c413b';
  const userId = '3P6hA4_aGNRjDrWLl';

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
      //  'user_name': name,
        'user_email': email,
        'user_subject': subject,
       // 'user_message': message,
      },
    }),
  );


}












 

 
 
 
 
 
 
 
 
 
 }
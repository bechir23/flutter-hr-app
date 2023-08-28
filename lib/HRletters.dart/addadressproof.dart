import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/HRletters.dart/yesno.dart';
import 'package:provider/provider.dart';



class addaddressproof extends StatefulWidget {
  const addaddressproof({super.key});

  @override
  State<addaddressproof> createState() => _addaddressproofState();
}

class _addaddressproofState extends State<addaddressproof> {
  final user=FirebaseAuth.instance.currentUser! ; 
      DateTime date=DateTime.now();  DateTime date1=DateTime.now();

//  final _emailcontroller=TextEditingController();
    final _requestcontroller=TextEditingController();
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();


     DateTime e=DateTime.now(); bool isLoading=false ;


// ignore: non_constant_identifier_names
Future Submit(String a,DateTime b,String c,String d)
async{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  await firestore.collection('addressproof').add(
  {
'email':a,
'request':b,
'reason':c,
'yesno':d
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
          ListTile(textColor: Colors.pink,leading: IconButton(icon:const Icon(Icons.cancel),onPressed:() {Provider.of<yesno>(context,listen: false).init();
         Navigator.pop(context);}),title: const Text('Add address proof')),
        
        
        
        
        const Text('Email'),
        
        Text(user.email != null ? user.email! : 'not enregistred')
        
        ,const SizedBox(height: 20,),
        
        
        
        
        
        
        
        
        
        const Text('Date of request'),
        
        Text('${date.day}/${date.month}/${date.year}'),
        
        ElevatedButton.icon(onPressed: ()async  { DateTime ? newDate =await     showDatePicker(
        
        context: context, initialDate: date, firstDate:DateTime(2000), lastDate: DateTime(2100));
        
        if (newDate==null) return;
        
        setState((){date=newDate;e=date;});
        
        }
        
        , icon:const Icon(Icons.calendar_today),label: const Text('Date of request',style: TextStyle(fontSize: 20),),),
        
        const SizedBox(height: 20,),
        
         ListTile(title: const Text('Is there any change in Present address'),trailing: IconButton(onPressed: ()
        {
        setState(() {
          Navigator.pushNamed(context,'change' );
          
        });
        }
        , icon: const Icon(Icons.navigate_next)),),
        Text(Provider.of<yesno>(context).scale),
        const SizedBox(height: 20,),
      
      
      
        const Text('Reason of request'),
        
        TextFormField(textAlign: TextAlign.center,autofocus: true,controller: _requestcontroller,validator:  (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the reason';
              }
              return null; 
            },),
        
        const SizedBox(height: 20,),
        
        
        
        
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
          //  Provider.of<traveldata>(context,listen:false).increment(_placecontroller.text, _purposecontroller.text);
              if ( formkey.currentState!.validate()){
            Submit(user.email ?? 'not enregistred',e,_requestcontroller.text,Provider.of<yesno>(context,listen: false).scale).then((value){Navigator.pop(context);});
            }else {isLoading=false;}},
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

    
 ; }}

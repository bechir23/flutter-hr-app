import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class addbonafideletter extends StatefulWidget {
  const addbonafideletter({super.key});

  @override
  State<addbonafideletter> createState() => _addbonafideletterState();
}

class _addbonafideletterState extends State<addbonafideletter> {
   final user=FirebaseAuth.instance.currentUser! ; 
      DateTime date=DateTime.now(); 
//  final _emailcontroller=TextEditingController();
    final _requestcontroller=TextEditingController();
    

     DateTime e=DateTime.now(); bool isLoading=false ;
final GlobalKey<FormState> formkey = GlobalKey<FormState>();

// ignore: non_constant_identifier_names
Future Submit(String a,DateTime b,String c)
async{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  await firestore.collection('bonafideletter').add(
  {
'email':a,
'request':b,
'reason':c

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
        
        ListTile(textColor: Colors.pink,leading: IconButton(icon:const Icon(Icons.cancel),onPressed:() {
         Navigator.pop(context);}),title: const Text('Add bonafide letter')),
        
        
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
            Submit(user.email ?? 'not enregistred',e,_requestcontroller.text,).then((value){Navigator.pop(context);});
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

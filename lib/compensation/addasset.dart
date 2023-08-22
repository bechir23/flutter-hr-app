import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/compensation/typeassets.dart';
import 'package:provider/provider.dart';

class addasset extends StatefulWidget {
  const addasset({super.key});

  @override
  State<addasset> createState() => _addassetState();
}

class _addassetState extends State<addasset> {

  final user=FirebaseAuth.instance.currentUser! ; 
      DateTime date=DateTime.now();  DateTime date1=DateTime.now();

//  final _emailcontroller=TextEditingController();
    final _assetcontroller=TextEditingController();


     DateTime e=DateTime.now(); DateTime f=DateTime.now();bool isLoading=false ;

        //  final _duecontroller=TextEditingController();

// ignore: non_constant_identifier_names
Future Submit(String a,DateTime b,String c,DateTime d,String e)
async{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  await firestore.collection('tabasset').add(
  {
'email':a,
'givendate':b,
'asset':c,

'returndate':d,
'scale':e
  }
  );

}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
      
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)),color: Colors.white),
      child:   Column(children: [
      
      ListTile(textColor: Colors.pink,leading: IconButton(icon:const Icon(Icons.cancel),onPressed:() {
       Navigator.pop(context);}),title: const Text('Add Asset')),
      
      
      const Text('Email'),
      
      Text(user.email != null ? user.email! : 'not enregistred')
      
      ,const SizedBox(height: 20,),
        
      const Text('Given Date'),
      
      Text('${date.day}/${date.month}/${date.year}'),
      
      ElevatedButton.icon(onPressed: ()async  { DateTime ? newDate =await     showDatePicker(
      
      context: context, initialDate: date, firstDate:DateTime(2000), lastDate: DateTime(2100));
      
      if (newDate==null) return;
      
      setState((){date=newDate;e=date;});
      
      }
      
      , icon:const Icon(Icons.calendar_today),label: const Text('SELECT',style: TextStyle(fontSize: 20),),),
      
      const SizedBox(height: 20,),
      
      
      
      
      
      const Text('Asset Details'),
      
      TextField(textAlign: TextAlign.center,autofocus: true,controller: _assetcontroller,),
      
      const SizedBox(height: 20,),



      
       
      ListTile(title: const Text('Type Of Asset'),trailing: IconButton(onPressed: ()
      {
      setState(() {
        Navigator.pushNamed(context,'type' );
        
      });
      }
      , icon: const Icon(Icons.navigate_next)),),
      Text(Provider.of<assets>(context).scale),
      
      
       const SizedBox(height: 20,),
      
      
    
      
      const Text('Return Date'),
      
      Text('${date1.day}/${date1.month}/${date1.year}'),
      
      ElevatedButton.icon(onPressed: ()async  { DateTime ? newDate1 =await     showDatePicker(
      
      context: context, initialDate: date, firstDate:DateTime(2000), lastDate: DateTime(2100));
      
      if (newDate1==null) return;
      
      setState((){date1=newDate1;f=date1;});
      
      }
      
      , icon:const Icon(Icons.calendar_today),label: const Text('SELECT',style: TextStyle(fontSize: 20),),),
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
          
          Submit(user.email ?? 'not enregistred',e,_assetcontroller.text,f,Provider.of<assets>(context,listen: false).scale).then((value){Navigator.pop(context);});
        },
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
    ) 

    
 ; }}

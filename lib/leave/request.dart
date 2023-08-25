import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class leaverequest extends StatefulWidget {
  static const screenroute='leaverequest';
  const leaverequest({super.key});

  @override
  State<leaverequest> createState() => _leaverequestState();
}

class _leaverequestState extends State<leaverequest> {
  String ? selecteditem='Vacation Time';
  List<String> itemslist=['Vacation Time','Sick Leave','Paid Time Off','Short/Long Term Disability','Personal Leave'];
   final user=FirebaseAuth.instance.currentUser! ; 
      DateTime date=DateTime.now();  DateTime date1=DateTime.now();
      final _reasoncontroller=TextEditingController();
           
     DateTime e=DateTime.now(); DateTime f=DateTime.now();bool isLoading=false ;
int number=1;
        

  Future Submit (String a,DateTime c,DateTime d,String e,String b)
    async { 
FirebaseFirestore firestore=FirebaseFirestore.instance;
await firestore.collection('request').add({
'email':a,
'start':Timestamp.fromDate(c),
'end':Timestamp.fromDate(d),
'reason':e,
'type':b,
});



    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(centerTitle:true,title: const Text('Send Request',style: TextStyle(color: Colors.white,fontSize: 40),),backgroundColor: const Color.fromARGB(255, 223, 130, 161),
      leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.exit_to_app)),) ,
      body: Center(
        child: SingleChildScrollView(
          child: Container(decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(12.0))),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
            
            
            
            
            const Text('Your Request'),
            
            Text(user.email != null ? user.email! : 'not enregistred')
            
            ,const SizedBox(height: 10,),
            
             Center(
             child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [ Text('${date.day}/${date.month}/${date.year}'),
              
              ElevatedButton.icon(onPressed: ()async  { DateTime ? newDate =await     showDatePicker(
              
              context: context, initialDate: date, firstDate:DateTime(2020), lastDate: DateTime(2040));
              
              if (newDate==null) return;
              
              setState((){date=newDate;e=date;});
              setState(() {
 if (isSameDay(date, date1)) {
        number = 1;
      } else {
        number = date1.difference(date).inDays + 1;
      }
    });}
                
              
              , icon:const Icon(Icons.calendar_today),label: const Text('Start',style: TextStyle(fontSize: 20),),),
              
              const SizedBox(width: 20,),
              Text('${date1.day}/${date1.month}/${date1.year}'),
              
              ElevatedButton.icon(onPressed: ()async  { DateTime ? newDate =await     showDatePicker(
              
              context: context, initialDate: date, firstDate:DateTime(date.year,date.month,date.day), lastDate: DateTime(2040));
              
              if (newDate==null) return;              setState((){date1=newDate;f=date1;});

        if (isSameDay(date, date1)) {
        number = 1;
      } else {
        number = date1.difference(date).inDays + 1;
      }
    ;
              
             
                           
              }
              
              , icon:const Icon(Icons.calendar_today),label: const Text('End',style: TextStyle(fontSize: 20),),),
              
              ],),
             ) 
            ,
            
            const SizedBox(height: 10,),
            
            
            
            const Text('Reason'),
            
            Container(alignment: Alignment.topLeft,height: 100,child: TextField(autofocus: true,controller: _reasoncontroller,textAlign: TextAlign.center,)),
            
            const SizedBox(height: 10,),
          Container(decoration:const BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.all(Radius.circular(12.0))),child: Text('Day off request is for $number',style:const TextStyle(color: Colors.white,fontSize: 20),),)      
            
            
             
            
             , const SizedBox(height: 10,),
                 
            const Text('Leave Type'),
            DropdownButton<String>(
            value:selecteditem,
            items: itemslist.map((item) => DropdownMenuItem(value: item,child: Text(item,style: const TextStyle(fontSize: 20),),)).toList(), 
            onChanged: (item) => setState(() {
               selecteditem=item;
            })),
             
             
            
            const SizedBox(height: 10,),
            
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
                Submit(user.email ?? 'not enregistred',e,f,_reasoncontroller.text,selecteditem!).then((value){Navigator.pop(context);});
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
        ),
      ),
            backgroundColor: const Color.fromARGB(255, 223, 130, 161),

    ) 

    
 ; }}
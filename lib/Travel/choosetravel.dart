import 'package:flutter/material.dart';
import 'package:myapp/Travel/traveldata.dart';
import 'package:provider/provider.dart';

class choosetravel extends StatefulWidget {
  static const String screenroute='choose';
  const choosetravel({super.key});

  @override
  State<choosetravel> createState() => _choosetravelState();
}

class _choosetravelState extends State<choosetravel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 114, 152),
        leading: IconButton(icon: const Icon(Icons.exit_to_app),onPressed: ()  {
    Provider.of<traveldata>(context,listen: false).update() ;
          setState(() {
         
          Navigator.pop(context);
      
        });
        
      },),title: const Text('Travel ID',textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 40),),),
        backgroundColor: const Color.fromARGB(255, 240, 128, 165),
        body: Container(
          child: Consumer<traveldata>(
      builder:(context, TravelData, child) {return ListView.builder(
        itemCount:TravelData.visits.length,
        itemBuilder:(context,index) {
        return   ListTile(
            title:  Text('TravelID${index+1}'),trailing: Checkbox(value:TravelData.values[index],onChanged: (value) {
                    setState(() {
                   
                   TravelData.values[index]= value!;
                       for(int i=0;(i<TravelData.visits.length)||(i!=index);i++) {TravelData.values[i]=false;}
                  
    
                    });
          
      },
      ));
  },);})));}}

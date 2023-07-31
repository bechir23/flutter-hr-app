import 'package:flutter/material.dart';

class NewTask extends StatelessWidget {
  final String name;
  final String press;
  const NewTask({super.key, required this.name,required this.press});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(100),
      child: GestureDetector(
        onTap: (){Navigator.pushNamed(context, press);},
        child: Container(
            decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all( Radius.circular(20))),
          child: Column(
           
            mainAxisAlignment: MainAxisAlignment.center,
            
            children:[
             const Icon(
              Icons.airplane_ticket,
             ),
              
              const SizedBox(height: 10,),
               Text(name,textAlign:TextAlign.center,
            style:const TextStyle(fontSize: 50,fontWeight: FontWeight.bold))]
          ),
        ),
      ),
    ) ;
  }
}
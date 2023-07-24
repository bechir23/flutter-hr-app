import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class list extends StatefulWidget {
  const list({super.key});

  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {
 @override
  void initState()
{super.initState();
ReadData();}
List  mylist=[];
Future <http.Response?> ReadData() async{
   
    http.Response FuturePost= await http.get(Uri.parse('http://192.168.1.13/myapp/readdata.php'));
    if (FuturePost.statusCode==200)
    { 
    //  var red=jsonDecode(FuturePost.body);
    //setState(() {
     // mylist.addAll(red);

       
    //});
    print(FuturePost);
    return null;
 }
  else {throw Exception('cannot');}
}

  
    @override
  Widget build(BuildContext context) {
    return Container();
  }}


      // ListView.builder(
     //   itemCount: mylist.length,
       // itemBuilder: (context,index)
        //{
          //return ListTile(
            //   leading: CircleAvatar(child: Text(mylist[index].toString().substring(0,2).toUpperCase())),
              // title: Text(mylist[index]['Task_owner']??''),
               //subtitle: Text(mylist[index]['Task_name']??''),
               //trailing: IconButton(icon: Icon(Icons.delete),onPressed: () {
                 //setState(() {
                   //mylist.remove(mylist[index]);
                // });
               ///},),
    
    
    
    
          //);
       // }
      
      
      
      
      //);
    
 // }


 
//}
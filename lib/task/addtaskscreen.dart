import 'package:flutter/material.dart';
import 'package:myapp/task/Listtasks.dart';
import 'package:myapp/task/valuecheckbox.dart';
import 'package:provider/provider.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateTime date=DateTime.now();
   
  @override
  Widget build(BuildContext context) {
    return Container(
    
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)),color: Colors.white),
    child:   Column(children: [
    
    ListTile(textColor: Colors.pink,leading: IconButton(icon:Icon(Icons.cancel),onPressed:() {
     Navigator.pop(context);}),title: Text('Task')),
    
    
    Text('Task Owner'),
    
    TextField(textAlign: TextAlign.center,autofocus: true,)
    
    ,SizedBox(height: 20,),
    
    
    
    
    
    Text('Task Name'),
    
    TextField(textAlign: TextAlign.center,autofocus: true,),
    
    SizedBox(height: 20,),
    
    
    
    
    
    Text('Description'),
    
    TextField(textAlign: TextAlign.center,autofocus: true,),
    
    SizedBox(height: 20,),
    
    
    
    Text('Start Date'),
    
    Text('${date.day}/${date.month}/${date.year}'),
    
    ElevatedButton.icon(onPressed: ()async  { DateTime ? newDate =await     showDatePicker(
    
    context: context, initialDate: date, firstDate:DateTime(2000), lastDate: DateTime(2100));
    
    if (newDate==null) return;
    
    setState((){date=newDate;});
    
    }
    
    , icon:Icon(Icons.calendar_today),label: Text('To Start',style: TextStyle(fontSize: 20),),),
    
    SizedBox(height: 20,),
    
    Text('Due Date'),
    
    Text('${date.day}/${date.month}/${date.year}'),
    
    ElevatedButton.icon(onPressed: ()async  { DateTime ? newDate1 =await     showDatePicker(
    
    context: context, initialDate: date, firstDate:DateTime(2000), lastDate: DateTime(2100));
    
    if (newDate1==null) return;
    
    setState((){date=newDate1;});
    
    }
    
    , icon:Icon(Icons.calendar_today),label: Text('Due Date',style: TextStyle(fontSize: 20),),),
    SizedBox(height: 20,),
    
    ListTile(title: Text('Priority'),trailing: IconButton(onPressed: ()
    {
    setState(() {
      Navigator.pushNamed(context,'priority' );
    });
    }
    , icon: Icon(Icons.navigate_next)),),
    Text(Provider.of<check>(context,listen: false).scale),
    
    
    
    Row(children:[
     
      Expanded(child: ElevatedButton(onPressed:(){Navigator.pop(context);},child: Text('Cancel',style: TextStyle(backgroundColor: Colors.red)))),
    SizedBox(width: 10,),
      Expanded(child: ElevatedButton(onPressed: (){;}, child:Text('Submit',style: TextStyle(backgroundColor: Colors.green),)))])
    
    
    
    
    
    
    
    
    
    ]),
    ) 

    
 ; }}
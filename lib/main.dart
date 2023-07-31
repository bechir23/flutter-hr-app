import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/AUTH.dart';
import 'package:myapp/Travel/TravelExpense.dart';
import 'package:myapp/Travel/TravelScreen.dart';
import 'package:myapp/Travel/choosetravel.dart';
import 'package:myapp/models/WidgetData.dart';
import 'package:myapp/screens/Signup.dart';
import 'package:myapp/screens/resetpass.dart';
import 'package:myapp/task/ADDTASK.dart';
import 'package:myapp/task/Priority.dart';
import 'package:myapp/task/taskdetails.dart';
import 'package:myapp/task/valuecheckbox.dart';

import 'Travel/TravelRequest.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

Future <void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [   ChangeNotifierProvider(   create: (context) => TaskData()),
      ChangeNotifierProvider(   create: (context) => check())
],
      child: MaterialApp(
       
        
        debugShowCheckedModeBanner: debugDisableShadows,
        home:const auth(),//TasksScreen(),// auth(),
        // const ,//Scrollbar(isAlwaysShown:true,child: TasksScreen()),
       routes: {AddTask.screenroute :(context) => const AddTask(),
       Degree.screenroute:(context) => const Degree(),
       TaskDetails.screenroute:(context) => const  TaskDetails(m:{},d:''),
       auth.screenroute:(context) => const auth(),
       signup.screenroute:(context) => const signup(),
              reset.screenroute:(context) => const reset(),
              travelscreen.screenroute:(context) => const travelscreen(),
              travelrequest.screenroute:(context) => const travelrequest(),
              travelexpense.screenroute:(context) => const travelexpense(),
              choosetravel.screenroute:(context) => const choosetravel(),


       },
      ),
    ) ;
    
  }
}


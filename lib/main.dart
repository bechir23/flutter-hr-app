import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/AUTH.dart';
import 'package:myapp/HRletters.dart/addadressproof.dart';
import 'package:myapp/HRletters.dart/addressproof.dart';
import 'package:myapp/HRletters.dart/bonafidedetails.dart';
import 'package:myapp/HRletters.dart/bonafideletter.dart';
import 'package:myapp/HRletters.dart/change.dart';
import 'package:myapp/HRletters.dart/experiencedetails.dart';
import 'package:myapp/HRletters.dart/experienceletter.dart';
import 'package:myapp/HRletters.dart/letterscreen.dart';
import 'package:myapp/HRletters.dart/proofdetails.dart';
import 'package:myapp/HRletters.dart/yesno.dart';
import 'package:myapp/Travel/TravelExpense.dart';
import 'package:myapp/Travel/TravelScreen.dart';
import 'package:myapp/Travel/addexpense.dart';
import 'package:myapp/Travel/choosetravel.dart';
import 'package:myapp/Travel/detailsdata.dart';
import 'package:myapp/Travel/expensedetails.dart';
import 'package:myapp/cases/addquestion.dart';
import 'package:myapp/cases/casesdetails.dart';
import 'package:myapp/cases/casesscreen.dart';
import 'package:myapp/cases/questions.dart';
import 'package:myapp/compensation/addmedical.dart';
import 'package:myapp/compensation/asset.dart';
import 'package:myapp/compensation/assetdetails.dart';
import 'package:myapp/compensation/benefit.dart';
import 'package:myapp/compensation/choosetype.dart';
import 'package:myapp/compensation/compensationscreen.dart';
import 'package:myapp/compensation/medical.dart';
import 'package:myapp/compensation/typeassets.dart';
import 'package:myapp/files/ADDFILE.dart';
import 'package:myapp/files/employeedetails.dart';
import 'package:myapp/files/fileview.dart';
import 'package:myapp/files/folderdata.dart';
import 'package:myapp/files/organizationdetails.dart';
import 'package:myapp/files/view.dart';
import 'package:myapp/leave/leave.dart';
import 'package:myapp/leave/request.dart';
import 'package:myapp/models/index.dart';
import 'package:myapp/models/traveldata.dart';
import 'package:myapp/models/widgetlist.dart';
import 'package:myapp/myattendance/attendance.dart';
import 'package:myapp/organization/addexit.dart';
import 'package:myapp/organization/colldept.dart';
import 'package:myapp/organization/exit.dart';
import 'package:myapp/organization/exitdetails.dart';
import 'package:myapp/organization/organizationscreen.dart';
import 'package:myapp/screens/Signup.dart';
import 'package:myapp/screens/Widget_Screen.dart';
import 'package:myapp/screens/companyinformation.dart';
import 'package:myapp/screens/resetpass.dart';
import 'package:myapp/task/ADDTASK.dart';
import 'package:myapp/task/Priority.dart';
import 'package:myapp/task/taskdetails.dart';
import 'package:myapp/task/valuecheckbox.dart';

import 'Travel/TravelRequest.dart';
import 'files/folder.dart';
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
      providers: [  ChangeNotifierProvider(   create: (context) => traveldata()),
                    ChangeNotifierProvider(   create: (context) => detailsdata()),
ChangeNotifierProvider(create:(context) => fileview(),),
ChangeNotifierProvider(create:(context) => yesno(),),
ChangeNotifierProvider(create:(context) => assets(),),
ChangeNotifierProvider(create:(context) => medicaldata(),),
ChangeNotifierProvider(create: (context)=>pos()),
                    ChangeNotifierProvider(   create: (context) => folderdata()),

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
                                        addexpenser.screenroute:(context) => const addexpenser(),
   choosetravel.screenroute: (context) => choosetravel( onAAndBChanged: (String newA, String newB) {  },),
                                           folder.screenroute:(context) => const folder(),
                                           AddFILE.screenroute:(context) => const AddFILE(),
 Organizationdetails.screenroute:(context) => const Organizationdetails(m: {}, d: ''),
 view.screenroute:(context) => const view(),

 employeedetails.screenroute:(context) => const employeedetails(m:{},d:''),
organizationscreen.screenroute:(context) => const organizationscreen(),
Company.screenroute:(context) => const Company(),
addexit.screenroute:(context) => const addexit(),
exitdetails.screenroute:(context) => const exitdetails(m: {}, d: ''),
questions.screenroute:(context) => const questions(),
casesdetails.screenroute:(context) => const casesdetails(m: {}, d: ''),
casesscreen.screenroute:(context) => const casesscreen(),
addquestion.screenroute:(context) => const addquestion(),
change.screenroute:(context) => const change(),
          // a: 'default_a_value', b: 'default_b_value',
          CompensationScreen.screenroute:(context) => const CompensationScreen()  ,
          experiencedetails.screenroute:(context) => const experiencedetails(m: {}, d: ''),
          experienceletter.screenroute:(context) => const experienceletter(),
          bonafidedetails.screenroute:(context) => const bonafidedetails(m: {}, d: ''),
          bonafideletter.screenroute:(context) => const bonafideletter(),
 letterscreen.screenroute:(context) => const letterscreen(), 
  proofdetails.screenroute:(context) => const proofdetails(m: {}, d: ''),
  addressproof.screenroute:(context) => const addressproof(),
  asset.screenroute:(context) => const asset(),
  assetdetails.screenroute:(context) => const assetdetails(m: {}, d: ''),
  choosetype.screenroute:(context) => const choosetype(),
  benefit.screenroute:(context) => const benefit(),
  addmedical.screenroute:(context) => const addmedical(),
  colldept.screenroute:(context) => const colldept(),
  expensedetails.screenroute:(context) => const expensedetails(m: {}, d: '', l: []),
  exit.screenroute:(context) => const exit(),
  attendance.screenroute:(context) => attendance(),
TasksList.screenroute:(context) => const TasksList(),
TasksScreen.screenroute:(context)=> const TasksScreen(),
leave.screenroute:(context) => const leave(),
leaverequest.screenroute:(context) => const leaverequest(),

  },)
    );}}    
    


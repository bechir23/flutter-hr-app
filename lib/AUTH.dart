import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/Widget_Screen.dart';
import 'package:myapp/screens/loginscreen.dart';

class auth extends StatelessWidget {
    static const  String screenroute='auth';

  const auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
          {return  const TasksScreen(); }
          else {return  const Login();}




        },
        )
      
      
      ,);
  }
}
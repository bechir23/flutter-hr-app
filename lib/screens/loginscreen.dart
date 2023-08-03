import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
    final  _emailcontroller=TextEditingController();
    final _passcontroller=TextEditingController();
  @override
    void dispose(){
super.dispose();
_emailcontroller.dispose();
_passcontroller.dispose();

    }
    Future SignIn() async
    {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailcontroller.text.trim(), password: _passcontroller.text.trim());
    }

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
 backgroundColor:  const Color.fromARGB(255, 224, 101, 142),
 body: Center(
   child: SingleChildScrollView(
     child: Column(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
     Image.asset('images/hr.jpg',height: 150,),
       const SizedBox(height: 20,),
   
      const Text('SIGN IN',style: TextStyle(fontSize: 40,fontWeight:FontWeight.bold,)),
      const Text('WELCOME BACK',style: TextStyle(fontSize: 18),),
     Padding (
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(borderRadius:BorderRadius.circular((12)),color: Colors.white,),
          child:  TextField(controller:_emailcontroller,decoration: const InputDecoration(hintText: 'EMAIL'),)),
      ),  Padding (
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(borderRadius:BorderRadius.circular((12)),color: Colors.white,),
          child:  TextField(controller:_passcontroller,decoration: const InputDecoration(hintText: 'PASSWORD'),)),
      ),
    const SizedBox(height: 20,),
      GestureDetector(
        onTap: SignIn,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
             decoration: BoxDecoration(borderRadius:BorderRadius.circular((12)),color: Colors.grey,),
            child: const Text('SIGN IN',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
        )),
      ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
        children:[
         const Text('Not a member yet?',style: TextStyle(color: Colors.black,fontSize: 18),),

         TextButton(onPressed: (){Navigator.pushNamed(context,'signup');},child:const Text('Sign Up Now',style: TextStyle(color: Colors.green,fontSize: 18),),)

        ]
        

      ),
   
    TextButton(onPressed: (){Navigator.pushNamed(context,'reset');},child: const Text('Forgot password?',style: TextStyle(color: Colors.green,fontSize: 18),)),
   
   
      ],
   
     
    
    
    
     ),
   ),
 ),







    );
  }
}
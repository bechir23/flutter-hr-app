import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  static const screenroute='signup';
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final  _emailcontroller=TextEditingController();
    final _passcontroller=TextEditingController();
    final _confirmpasscontroller=TextEditingController();
  @override
    void dispose(){
super.dispose();
_emailcontroller.dispose();
_passcontroller.dispose();
_confirmpasscontroller.dispose();

    }
    Future SignUp() async
    {
      
      if (confirmpass())
      
  {  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailcontroller.text.trim(), password: _passcontroller.text.trim());
    Navigator.pushNamed(context,'auth');
    }
      } 
    
    

    bool confirmpass()
    {
      if (_passcontroller.text.trim()==_confirmpasscontroller.text.trim()) return true; 
      return false ;
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
   
      const Text('SIGN UP',style: TextStyle(fontSize: 40,fontWeight:FontWeight.bold,)),
      const Text('WELCOME! HERE YOU CAN SIGN UP ',style: TextStyle(fontSize: 18),),
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
      const SizedBox(height: 5,),
    const   Text('Six characters at least ',style: TextStyle(color: Color.fromARGB(255, 224, 215, 215),fontSize: 18),),
      const SizedBox(height: 5,),

       Padding (
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(borderRadius:BorderRadius.circular((12)),color: Colors.white,),
          child:  TextField(controller:_confirmpasscontroller,decoration: const InputDecoration(hintText: 'CONFIRM PASSWORD'),)),
      ),
    const SizedBox(height: 20,),
      GestureDetector(
        onTap: SignUp,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
             decoration: BoxDecoration(borderRadius:BorderRadius.circular((12)),color: Colors.grey,),
            child: const Text('SIGN UP',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
        )),
      ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
        children:[
         const Text('Already a member?',style: TextStyle(color: Colors.black,fontSize: 18),),

         TextButton(onPressed: (){Navigator.pop(context);},child:const Text('Sign In Here',style: TextStyle(color: Colors.green,fontSize: 18),),)

        ]
        

      ),
   
   
     
    
    
    
  ]),
   ),
 ),







    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class reset extends StatefulWidget {
  static const screenroute = 'reset';
  const reset({super.key});

  @override
  State<reset> createState() => _resetState();
}

class _resetState extends State<reset> {
  final _emailcontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
  }

  Future Reset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailcontroller.text.trim());
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text('Password reset link sent! Check your email'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('Check your Email.'),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: const Color.fromARGB(255, 223, 130, 161),
          ),
          backgroundColor: const Color.fromARGB(255, 224, 101, 142),
          body: Center(
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                Image.asset(
                  'images/hr.jpg',
                  height: 150,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Receive an email to reset your password',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    )),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular((12)),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: _emailcontroller,
                        decoration: const InputDecoration(hintText: 'EMAIL'),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: Reset,
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular((12)),
                          color: Colors.green,
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.email),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Reset Password',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      )),
                )
              ])))),
    );
  }
}

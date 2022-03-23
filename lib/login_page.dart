import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    handleLogin() async {
      if (emailController.text.isEmpty || passController.text.isEmpty) return;

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passController.text);
        Navigator.pushNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[                      
                Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                // Email box
                Container(
                  height: 45,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  margin: EdgeInsets.only(top: 12),
                  child: Center(
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                // Password box
                Container(
                  height: 45,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  margin: EdgeInsets.only(top: 12),
                  child: Center(
                    child: TextFormField(
                      controller: passController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        icon: Icon(Icons.lock),
                        suffixIcon: Icon(
                          Icons.visibility,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                    width: double.infinity,
                    color: Colors.white70,
                    margin: EdgeInsets.only(top: 15),
                    child: TextButton(
                        onPressed: handleLogin,
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.black87),
                        ))),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      "Create New Account",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            )),
      ),
    );
  }
}

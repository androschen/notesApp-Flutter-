import 'package:finalprojectgdsc/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RegisterPage extends StatelessWidget {

  final TextEditingController nameController = TextEditingController(text:'');
  final TextEditingController emailController = TextEditingController(text:'');
  final TextEditingController phoneController = TextEditingController(text:'');
  final TextEditingController passController = TextEditingController(text:'');
  final TextEditingController confirmPassController = TextEditingController(text:'');

  @override
  Widget build(BuildContext context) {

    saveUserToDatabase(UserModel user) async{
      FirebaseFirestore.instance.collection('users').doc(user.email).get().then((value){
        if(!value.exists)
          FirebaseFirestore.instance.collection('users').doc(user.email).set(user.toJson());
      });
    }

    handleRegister() async{
      if(nameController.text.isEmpty || emailController.text.isEmpty || phoneController.text.isEmpty || passController.text.isEmpty || confirmPassController.text.isEmpty) return;

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passController.text
        );

        UserModel user = UserModel(
          name: nameController.text, 
          email: emailController.text, 
          phone: phoneController.text, 
          password: passController.text);
        //store data user to database
        saveUserToDatabase(user);

        Navigator.pushNamed(context,'/');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
  }

    return Scaffold(
      body: SafeArea(
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Register",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                // Name box
                 Container(
                  height: 45,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  margin: EdgeInsets.only(top: 12),
                  child: Center(
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration.collapsed(hintText: "Name"),
                    ),
                  ),
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
                      decoration: InputDecoration.collapsed(hintText: "Email"),
                    ),
                  ),
                ),
                //Phone number Box
                 Container(
                  height: 45,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  margin: EdgeInsets.only(top: 12),
                  child: Center(
                    child: TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration.collapsed(hintText: "Phone Number"),
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
                      decoration:
                          InputDecoration.collapsed(hintText: "Password"),
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  margin: EdgeInsets.only(top: 12),
                  child: Center(
                    child: TextFormField(
                      controller: confirmPassController,
                      decoration:
                          InputDecoration.collapsed(hintText: "Confirm Password"),
                    ),
                  ),
                ),
                Container(
                    width: double.infinity,
                    color: Colors.white70,
                    margin: EdgeInsets.only(top: 15),
                    child: TextButton(
                        onPressed: handleRegister,
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.black87),
                        )
                    )
                ),
                Center(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("Already have an account?"),
                  TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(color: Colors.blue),
                          )
                  ),

                  ],)
                )
              ],
            )),
      ),
    );
  }
}

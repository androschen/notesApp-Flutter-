import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  late String title;
  late String desc;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 20,
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[700]),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: add,
                    child: Icon(Icons.check_rounded),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue[700]),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 13,
              ),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration.collapsed(hintText: "Title"),
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[300]),
                    onChanged: (_val) {
                      title = _val;
                    },
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.75,
                    padding: const EdgeInsets.only(top: 14.0),
                    child: TextFormField(
                      decoration:
                          InputDecoration.collapsed(hintText: "Description"),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[400]),
                      onChanged: (_val) {
                        desc = _val;
                      },
                      maxLines: 22,
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    ));
  }
  void add() async{
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('notes');

    var data = {
      'title' : title,
      'description' : desc,
      'created' : DateTime.now(),
    };

    ref.add(data);

    Navigator.pop(context);
  }
}


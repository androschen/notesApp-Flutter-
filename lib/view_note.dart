import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget {
  late final Map data;
  late final String times;
  late final DocumentReference ref;

  ViewNote(this.data, this.times, this.ref);

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  late String title;
  late String desc;

  bool editNote = false;
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //taking data from firebase to variable
    title = widget.data['title'];
    desc = widget.data['description'];

    return SafeArea(
        child: Scaffold(
      floatingActionButton: editNote
          ? FloatingActionButton(
              onPressed: update,
              child: Icon(Icons.check),
              backgroundColor: Colors.blue,
            )
          : null,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            editNote = !editNote;
                          });
                        },
                        child: Icon(Icons.edit_rounded),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8)),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        onPressed: delete,
                        child: Icon(Icons.delete_rounded),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red[700]),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 13,
              ),
              Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     TextFormField(
                      decoration: InputDecoration.collapsed(hintText: "Title"),
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[300]),
                      initialValue: widget.data['title'],
                      enabled: editNote,
                      onChanged: (_val) {
                        title = _val;
                      },
                      validator: (_val){
                        if(_val!.isEmpty){
                          return("Can't be Empty");
                        }else{
                          return null;
                        }
                      },
                    ),
              
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Text(
                        widget.times,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
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
                        initialValue: widget.data['description'],
                        enabled: editNote,
                        onChanged: (_val) {
                          desc = _val;
                        },
                        validator: (_val){
                          if(_val!.isEmpty){
                            return("Can't be Empty");
                          }else{
                            return null;
                          }
                        },

                        maxLines: 22,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  void update() async{
    if(key.currentState!.validate()){
      await widget.ref.update({'title': title, 'description': desc });
      Navigator.of(context).pop();
    }
  }

  void delete() async{
    await widget.ref.delete();
    Navigator.pop(context);
  }

  
}

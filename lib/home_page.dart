import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalprojectgdsc/add_note.dart';
import 'package:finalprojectgdsc/view_note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddNote(),
            ),
          ).then((value){
            print("Call Set State!");
            setState(() {
              
            });
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white70,
        ),
        backgroundColor: Colors.grey[700],
      ),
      appBar: AppBar(
        title: Text(
          "My Notes",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Color(0xff070706),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: ref.get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if(snapshot.data!.docs.length==0){
                return Center(
                  child: Text(
                    "Let's make some Notes !",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    //Data
                    Map data = snapshot.data!.docs[index].data();
                    DateTime date = data['created'].toDate();
                    String formatTime= DateFormat.yMMMd().add_jm().format(date);
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=> ViewNote(data, formatTime, snapshot.data!.docs[index].reference),)
                          ).then((value){
                            print("Call Set State!");
                            setState(() {
                              
                            });
                          });
                      },
                      child: Card(
                        color: Colors.white70,
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data['title']}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${data['description']}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  DateFormat.yMMMd().add_jm().format(date),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text("Loading..."),
              );
            }
          }),
    );
  }
}

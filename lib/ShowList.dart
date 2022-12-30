import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class ShowList extends StatelessWidget {
  const ShowList({Key? key}) : super(key: key);

  static final ref = FirebaseDatabase(databaseURL: "https://plxntask-759a1-default-rtdb.asia-southeast1.firebasedatabase.app").reference();
  static const String _title = 'PLXN Title';
  static String cc = "";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title),),
        body: Column(
          children: [
            Expanded(
                child: FirebaseAnimatedList(
                  query: ref.child("Persons"),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                    return Column(
                      children: <Widget>[
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.blueAccent)
                        // ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('All Details'),
                                    content: SingleChildScrollView(
                                      child: Text(
                                              "name : " + ((snapshot.value as Map) ["Name"]) +
                                              "\nAge : " + ((snapshot.value as Map) ["Age"]) +
                                              "\nGender : " + ((snapshot.value as Map) ["Gender"]) +
                                              "\nGST Number : " + ((snapshot.value as Map) ["GST Number"]) +
                                              "\nPhone Number : " + ((snapshot.value as Map) ["Phone Number"])
                                      ),
                                    ),

                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],

                                  );
                                }
                            );


                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent)
                            ),
                            child: Text(
                              (snapshot.value as Map) ["Email"],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                            ),

                          ),

                        )


                      ],
                    );
                  },

                ),
            )
          ],
        ),
      ),
    );
  }
}

Widget customeEmail() {
  return Container(
      width: 200,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //     border: Border.all(color: Colors.blueAccent)
      // ),
      child: const Text(
        'Fill the Details',
        style: TextStyle(fontSize: 25),
      )
  );
}
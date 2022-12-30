import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'ShowList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'PLXN Task';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title),),
        body: const MyStatefullWidget(),
      ),
    );
  }
}

class MyStatefullWidget extends StatefulWidget {
  const MyStatefullWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefullWidget> createState() => _MyStatefullWidgetState();
}

class _MyStatefullWidgetState extends State<MyStatefullWidget> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[

          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              // decoration: BoxDecoration(
              //     border: Border.all(color: Colors.blueAccent)
              // ),
              child: const Text(
                'Fill the Details',
                style: TextStyle(fontSize: 25),
              )
          ),

          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: ageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Age',
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: genderController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Gender',
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: gstNumberController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'GST Number',
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone Number',
              ),
            ),
          ),

          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ElevatedButton(
                child: const Text('Upload Details'),
                onPressed: () async {

                  if(nameController.text.isEmpty || emailController.text.isEmpty || ageController.text.isEmpty || genderController.toString().isEmpty || gstNumberController.text.isEmpty || phoneNumberController.text.isEmpty) {
                    print("Please fill all details.");
                  }
                  else{
                    DatabaseReference ref = FirebaseDatabase(databaseURL: "https://plxntask-759a1-default-rtdb.asia-southeast1.firebasedatabase.app").reference();
                    await ref.child("Persons").push().set({
                      "Name": nameController.text.toString(),
                      "Email": emailController.text.toString(),
                      "Age": ageController.text.toString(),
                      "Gender": genderController.text.toString(),
                      "GST Number": gstNumberController.text.toString(),
                      "Phone Number": phoneNumberController.text.toString()
                    }).then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Details successfully uploaded."),
                    )));

                    // Fluttertoast.showToast(
                    //     msg:'This is toast notification',
                    //     toastLength:Toast.LENGTH_SHORT,
                    //     gravity:ToastGravity.BOTTOM,
                    //     timeInSecForIosWeb: 1,
                    //     backgroundColor:Colors.red,
                    //     textColor:Colors.yellow
                    // );
                  }

                },
              )
          ),

          Container(
              height: 60,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: ElevatedButton(
                child: const Text('See All Records'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ShowList()),
                  );
                },
              )
          ),


        ],
      ),
    );
  }
}

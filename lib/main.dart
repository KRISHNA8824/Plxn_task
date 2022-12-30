import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
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


  late String imageUrl;

  uploadImage() async{
    PickedFile? image;
    final _imagePicker = ImagePicker();

    // Create a storage reference from our app
    final storageRef = FirebaseStorage.instance.ref();

    // Create a reference to "mountains.jpg"
    final mountainsRef = storageRef.child("mountains.jpg");

    // Create a reference to 'images/mountains.jpg'
    final mountainImagesRef = storageRef.child("images/mountains.jpg");

    // While the file names are the same, the references point to different files
    assert(mountainsRef.name == mountainImagesRef.name);
    assert(mountainsRef.fullPath != mountainImagesRef.fullPath);

    image = await _imagePicker.getImage(source: ImageSource.gallery);
    if(image!=null){
      //Upload to Firebase
      var file = File(image.path);
      var snapshot = await mountainsRef.putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();

      setState((){
        imageUrl = downloadUrl;
      });
      print(imageUrl);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("The photo is uploaded successfully."),
      ));

    } else {
      print('No Image Path Received');
    }

  }

  var downloadURL;
  Future<void> downloadURLExample() async {
        downloadURL = await FirebaseStorage.instance
        .ref()
        .child("mountains.jpg")
        .getDownloadURL();

        print(downloadURL);

  }


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(5),
      child: ListView(
        children: <Widget>[

          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              // decoration: BoxDecoration(
              //     border: Border.all(color: Colors.blueAccent)
              // ),
              child: const Text(
                'Fill the Details',
                style: TextStyle(fontSize: 25),
              )
          ),

          CustomeButton(title: "Pick and upload a photo from gallery", icon: Icons.image_outlined, onClick: uploadImage),

          Container(
            padding: const EdgeInsets.all(5),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(5),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(5),
            child: TextField(
              controller: ageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Age',
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(5),
            child: TextField(
              controller: genderController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Gender',
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(5),
            child: TextField(
              controller: gstNumberController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'GST Number',
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(5),
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
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: ElevatedButton(
                child: const Text('Upload Details'),
                onPressed: () async {

                  if(nameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please fill name"),
                    ));
                  }
                  else if(emailController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please fill email"),
                    ));
                  }
                  else if(ageController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please fill age"),
                    ));
                  }
                  else if(genderController.toString().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please fill age"),
                    ));
                  }
                  else if(gstNumberController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please fill GST Number"),
                    ));
                  }
                  else if(phoneNumberController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Please fill Phone Number"),
                    ));
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

                  }

                },
              )
          ),

          Container(
              height: 60,
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: ElevatedButton(
                child: const Text('See All Records'),
                onPressed: () {
                  // downloadURLExample();
                  // uploadImage();
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

Widget CustomeButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return Container(
    padding: const EdgeInsets.all(5),
    child: ElevatedButton(
      onPressed: onClick,
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 20,),
          Text(title)
        ],
      ),
    ),
  );
}

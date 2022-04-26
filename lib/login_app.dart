import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/main.dart';
import 'package:final_project/profile.dart';
import 'package:final_project/trending.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

import 'browse.dart';


String username = '';
String date_registered = '';
List favs = [];
class LoginApp extends StatefulWidget {
  const LoginApp();


  @override
  _LoginAppState createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  var current_index = 0;
  void onTapped(int index) {
    setState(() {
      current_index = index;
    });
  }


  void getUsernameAndDate() async {
    final _auth = FirebaseAuth.instance.currentUser?.email;
    final firestore = FirebaseFirestore.instance;
    final users = await firestore.collection("Users").get();
    for (var x in users.docs) {
      if (x.data()["email"] == _auth) {
        username = x.data()['username'];
        date_registered = x.data()['registration_time'];
      }
    }



  }

  @override
  Widget build(BuildContext context) {
    getUsernameAndDate();
    return Scaffold(
      backgroundColor:Color.fromRGBO(12, 48, 73, 1.0),
      appBar: AppBar(
        title: Text(username, style: TextStyle(
          color: Colors.deepOrange,fontSize: 26,
        ),),
       centerTitle: false,
       backgroundColor: Color.fromRGBO(12, 48, 73, 1.0),
        leading: Text(""),
        actions: [
          IconButton(
              onPressed:(){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              }, icon: Icon(Icons.logout),color : Colors.deepOrange),
          SizedBox(width: 10,),
        ],
      ),

      body: checkPage(current_index),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(12, 48, 73, 1.0),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(
            Icons.whatshot,
            color: Colors.deepOrange,
          ),
          label:"Trending" ,),
          BottomNavigationBarItem(icon: Icon(
            Icons.apps_outlined,
            color: Colors.deepOrange,
          ),
              label: "Browse",),
          BottomNavigationBarItem(icon: Icon(
            Icons.person,
            color: Colors.deepOrange,
          ),
              label: "Profile"),

        ],
        selectedItemColor: Colors.deepOrange,
        currentIndex: current_index,
        onTap: onTapped,



      ),

    );
  }
}
checkPage(int index) {
  if (index == 0) {
    return Trending();
  }
  else if (index == 1){
    return Browse();
  }
  else if (index == 2){

    return Profile(username, date_registered);
  }
}





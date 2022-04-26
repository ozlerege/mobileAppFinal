import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/CreateAccount.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'login_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _auth = FirebaseAuth.instance;
  String username = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://i.pinimg.com/736x/d0/33/b8/d033b81efcb43ba8b65d78f55f904104.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.darken),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 220,
              ),
              Stack(
                children: [
                  Text("Moviesm",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w800,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = Colors.white,
                      )),
                  Text("Moviesm",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w800,
                        color: Colors.deepOrange,
                      )),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(18),
                child: TextFormField(
                  onChanged: (value) {
                    username = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.deepOrange),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.deepOrange),
                      ),
                      icon: Icon(
                        Icons.person,
                        color: Colors.deepOrange,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter Your Username",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.deepOrange,
                        fontFamily: "RobotoMono",
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18),
                child: TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.deepOrange),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      icon: Icon(
                        Icons.password,
                        color: Colors.red,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.deepOrange,
                        fontFamily: "RobotoMono",
                      )),
                ),
              ),
              FloatingActionButton.extended(
                heroTag: "Button1",
                backgroundColor: Colors.deepOrange,
                label: Text("Login"),
                icon: Icon(Icons.login),
                onPressed: () async {
                  try {
                    final oldUser = await _auth.signInWithEmailAndPassword(
                        email: username, password: password);
                    if (oldUser != null) {


                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginApp()));
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Don`t have an account?",
                style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 24,
                    fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton.extended(
                heroTag: "Button2",
                backgroundColor: Colors.deepOrange,
                label: Text("Create An Account"),
                icon: Icon(Icons.people),
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateAccount()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

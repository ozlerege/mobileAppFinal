import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/login_app.dart';
import 'package:final_project/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String email = '';
  String username = '';
  String password = '';
  String conf_password = '';
  bool oneNum = false;
  bool oneSpecial = false;
  bool oneCapital = false;
  bool length = false;
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final String text = _controller.text;
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  Future<String?> Alert() {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('AlertDialog Title'),
              content: const Text('AlertDialog description'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://i.pinimg.com/736x/d0/33/b8/d033b81efcb43ba8b65d78f55f904104.jpg'),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          Padding(
            padding: EdgeInsets.all(18),
            child: TextFormField(
              onChanged: (value) {
                email = value;
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
                    Icons.mail,
                    color: Colors.deepOrange,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Enter Your Email",
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
                    Icons.person_add,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _controller,
                    onChanged: (value) {
                      password = value;
                      setState(() {
                        password = _controller.text;
                        oneNum = false;
                        oneCapital = false;
                        oneSpecial = false;
                        length = false;
                        for (int i = 0; i < password.length; i++) {
                          if (['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
                              .contains(password[i])) {
                            oneNum = true;
                          } else if ([
                            '!',
                            '@',
                            '#',
                            '\$',
                            '%',
                            '^',
                            '&',
                            '*',
                            '?',
                            '!',
                            '<',
                            '>'
                          ].contains(password[i])) {
                            oneSpecial = true;
                          } else if ([
                            'Q',
                            'W',
                            'E',
                            'R',
                            'T',
                            'Y',
                            'U',
                            'I',
                            'O',
                            'P',
                            'A',
                            'S',
                            'D',
                            'F',
                            'G',
                            'H',
                            'J',
                            'K',
                            'L',
                            'M',
                            'N',
                            'B',
                            'V',
                            'C',
                            'X',
                            'Z'
                          ].contains(password[i])) {
                            oneCapital = true;
                          }
                        }
                        if (password.length >= 8) {
                          length = true;
                        }
                      });
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
                  Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Icon(
                        (length == false) ? Icons.backspace : Icons.check,
                        color: length == false ? Colors.red : Colors.green,
                      ),
                      Text(
                        " At Least 8 Characters",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Icon(
                        (oneSpecial == false) ? Icons.backspace : Icons.check,
                        color: oneSpecial == false ? Colors.red : Colors.green,
                      ),
                      Text(
                        " At Least One Special Character",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Icon(
                        (oneNum == false) ? Icons.backspace : Icons.check,
                        color: oneNum == false ? Colors.red : Colors.green,
                      ),
                      Text(
                        " At Least One Number",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Icon(
                        (oneCapital == false) ? Icons.backspace : Icons.check,
                        color: oneCapital == false ? Colors.red : Colors.green,
                      ),
                      Text(
                        "At Least One Capital Letter",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ],
              )),
          Padding(
            padding: EdgeInsets.all(18),
            child: TextFormField(
              onChanged: (value) {
                conf_password = value;
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
                  hintText: "Confirm Password",
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.deepOrange,
                    fontFamily: "RobotoMono",
                  )),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          FloatingActionButton.extended(
              heroTag: "Button4",
              backgroundColor: Colors.deepOrange,
              label: Text("Create An Account"),
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () async {
                if (oneCapital &&
                    oneNum &&
                    oneSpecial &&
                    length &&
                    username != '' &&
                    password == conf_password) {
                  try {

                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      print("Hey");
                      var time  = DateFormat('yyyy-MM-dd').format(DateTime.now());
                      firestore.collection("Users").doc(username).set({
                        'email':email,
                        'username': username,
                        'password': password,
                        'registration_time':time,
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginApp()));
                    }
                  } catch (e) {
                  }
                } else {
                  return showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                              backgroundColor: Colors.black,
                              content: Text(
                                "Error While Creating An Account. Make sure you did the following",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
                              ),
                              actions: [
                                Center(
                                    child: Column(
                                  children: [
                                    Text(
                                      "- Entered Email",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "- Entered Username",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "- Met Password Requirements",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "- Entered Password and Confirmation",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "- Confirmation Password same as Password",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    FloatingActionButton.extended(
                                      heroTag: "Button 100",
                                      backgroundColor: Colors.deepOrange,
                                      label: Text("Acknowledged",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white)),
                                      onPressed: () async {
                                        Navigator.pop(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreateAccount()));
                                      },
                                    )
                                  ],
                                ))
                              ]));
                }
              }),
          SizedBox(
            height: 30,
          ),
          FloatingActionButton.extended(
            heroTag: "Button5",
            backgroundColor: Colors.deepOrange,
            label: Text("Back To Login"),
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () async {
              Navigator.pop(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
        ],
      ),
    ));
  }
}


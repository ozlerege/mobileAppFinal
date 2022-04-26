import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/login_app.dart';
import 'package:final_project/trending.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/search_model.dart';
import 'movie_description.dart';

class Profile extends StatefulWidget {
  const Profile(this.username, this.date);
  final String username;
  final String date;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 120.0,
            top: 20,
            right: 120,
          ),
          height: 150.0,
          width: 150.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://thumbs.dreamstime.com/b/default-avatar-profile-vector-user-profile-default-avatar-profile-vector-user-profile-profile-179376714.jpg"),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: new TextSpan(
                style: new TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(
                      text: 'Username: ',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w800,
                      )),
                  new TextSpan(
                      text: widget.username,
                      style: TextStyle(
                        fontSize: 24.0,
                        color:Colors.white
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RichText(
              text: new TextSpan(
                style: new TextStyle(
                  fontSize: 24.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  new TextSpan(
                      text: 'Date Registered: ',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w800,
                      )),
                  new TextSpan(
                      text: widget.date,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text("FAVORITE MOVIES",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 24.0,
                  color: Colors.deepOrange,
                )),
            FutureBuilder<List>(
              future: getFavs(),
              builder:( context,snapshot){
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }
                if(snapshot.data != null){
                  return Container(
                    height: 500,
                    width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(12, 48, 73, 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              Icon(
                                Icons.volunteer_activism,
                                color: Colors.red,
                              ),
                          Text(' ${snapshot.data![index]["movie_name"]}', style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600,color: Colors.white),),
                              SizedBox(height: 50,),
                            ],
                          );






                        }));

                }
                return Text('');
              },
            )
          ],
        ),
      ],
    ));
  }
}
Future<List> getFavs() async{
  List current_favs = [];
  final firestore = FirebaseFirestore.instance;
  final favs = await firestore.collection("Users")
      .doc(username)
      .collection("fav_movies")
      .get();
  for (var x in favs.docs) {
    current_favs.add(x.data());
  }
  return current_favs;
}

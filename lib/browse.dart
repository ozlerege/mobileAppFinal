import 'package:final_project/nowPlaying.dart';
import 'package:final_project/recommended.dart';
import 'package:final_project/releaseDate.dart';
import 'package:final_project/searchMovie.dart';
import 'package:final_project/searchPeople.dart';
import 'package:final_project/topRated.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class Browse extends StatefulWidget {
  const Browse({Key? key}) : super(key: key);

  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromRGBO(15, 73, 114, 1.0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.purple,size: 30,),
                  SizedBox(width: 20,),
                  Text("Search A Movie",style:
                  TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'RobotoMono'
                  ),)
                ],
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchMovie()));
              },

            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              color:  Color.fromRGBO(15, 73, 114, 1.0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              child: Row(
                children: [
                  Icon(Icons.people, color: Colors.yellow,size: 30,),
                  SizedBox(width: 20,),
                  Text("Search A People",style:
                  TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'RobotoMono'
                  ),)
                ],
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPeople()));
              },

            ),
          ),
          SizedBox(height: 15,),
          Container(
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromRGBO(15, 73, 114, 1.0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              child: Row(
                children: [
                  Icon(Icons.add_alert_sharp, color: Colors.green,size: 30,),
                  SizedBox(width: 20,),
                  Text("Release Dates",style:
                  TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'RobotoMono'
                  ),)
                ],
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReleaseDate()));
              },

            ),
          ),
          SizedBox(height: 15,),
          Container(
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              color:  Color.fromRGBO(15, 73, 114, 1.0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              child: Row(
                children: [
                  Icon(Icons.access_time_sharp, color: Colors.blue,size: 30,),
                  SizedBox(width: 20,),
                  Text("Now Playing",style:
                  TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'RobotoMono'
                  ),)
                ],
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NowPlaying()));
              },

            ),

          ),
          SizedBox(height: 15,),
          Container(
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              color:  Color.fromRGBO(15, 73, 114, 1.0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              child: Row(
                children: [
                  Icon(Icons.volunteer_activism, color: Colors.pink,size: 30,),
                  SizedBox(width: 20,),
                  Text("Top Rated",style:
                  TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'RobotoMono'
                  ),)
                ],
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TopRated()));
              },

            ),
          ),
          SizedBox(height: 16,),
          Container(
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromRGBO(15, 73, 114, 1.0),
              borderRadius: BorderRadius.circular(20),

            ),
            child: TextButton(
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.cyanAccent,size: 30,),
                  SizedBox(width: 20,),
                  Text("Get Recommended",style:
                  TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'RobotoMono'
                  ),)
                ],
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Recommended()));
              },

            ),
          ),

        ],
      ),
    );

  }
}
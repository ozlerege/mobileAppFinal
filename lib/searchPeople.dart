
import 'package:final_project/models/getSearchedMovie.dart';
import 'package:final_project/models/getSearchedPeople.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPeople extends StatefulWidget {
  const SearchPeople({Key? key}) : super(key: key);

  @override
  _SearchPeopleState createState() => _SearchPeopleState();
}

class _SearchPeopleState extends State<SearchPeople> {
  String keyword = '';
  String region = '';
  String url ='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(12, 48, 73, 1.0),
        iconTheme: IconThemeData(
          color: Colors.deepOrange, //change your color here
        ),
        title: Text(
          "Search A People",style: TextStyle(
          color: Colors.deepOrange,
          fontSize: 30,
        ),
        ),
      ),
      backgroundColor: Color.fromRGBO(12, 48, 73, 1.0),
      body: Column(
        children: [
          SizedBox(
            height: 150,
          ),

          Padding(
            padding: EdgeInsets.all(18),
            child: TextFormField(
              onChanged: (value) {
                keyword = value;
              },
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.deepOrange),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.deepOrange),

                  ),
                  icon: Icon(Icons.person,
                    color: Colors.deepOrange,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Actor Name (Jessica Chastain)",
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.deepOrange,
                    fontFamily: "RobotoMono",

                  )
              ),),),

          Padding(
            padding: EdgeInsets.all(18),
            child: TextFormField(
              onChanged: (value) {
                region = value;
              },
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.deepOrange),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(color: Colors.deepOrange),

                  ),
                  icon: Icon(Icons.vpn_lock,
                    color: Colors.deepOrange,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Region (U.S)",
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.deepOrange,
                    fontFamily: "RobotoMono",

                  )
              ),),),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton.extended(
            heroTag: "Button8",
            backgroundColor: Colors.deepOrange,
            label: Text("Search"),
            icon: Icon(Icons.search),
            onPressed: () async {
            if(keyword.isNotEmpty && region.isNotEmpty){
              url = "https://api.themoviedb.org/3/search/person?api_key=f717d34cc88a111bceead2fe8c1a9af8&query="+keyword+"&page=1&include_adult=false&region="+region;
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GetSearchedPeople(url)));
            }
            else if(keyword.isNotEmpty && region.isEmpty){
              url = "https://api.themoviedb.org/3/search/person?api_key=f717d34cc88a111bceead2fe8c1a9af8&query="+keyword+"&page=1&include_adult=false";
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GetSearchedPeople(url)));
            }else{
              print("error");
            }
            },

          ),

        ],
      ),
    );
  }
}

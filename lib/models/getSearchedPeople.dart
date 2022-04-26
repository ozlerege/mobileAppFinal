import 'dart:convert';

import 'package:final_project/models/search_people_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class GetSearchedPeople extends StatefulWidget {
  GetSearchedPeople(this.url);
  final String url;

  @override
  _GetSearchedPeopleState createState() => _GetSearchedPeopleState();
}

class _GetSearchedPeopleState extends State<GetSearchedPeople> {
  List<dynamic> searchPeople = <Search_People>[];
  final image_url_start = "https://www.themoviedb.org/t/p/w1280";

  @override
  void initState() {
    super.initState();
    _populateAllMovies();
  }


  Future<List<dynamic>> fetchSearchPeople() async {
    final response = await http.get(Uri.parse(widget.url));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["results"];
      return list.map((search_people) => Search_People.fromJson(search_people))
          .toList();
    } else {
      throw Exception("Error");
    }
  }

  void _populateAllMovies() async {
    final _searchPeople = await fetchSearchPeople();
    setState(() {
      searchPeople = _searchPeople;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color.fromRGBO(12, 48, 73, 1.0),
        iconTheme: IconThemeData(
          color: Colors.deepOrange, //change your color here
        ),
        title: Text("Results", style: TextStyle(
          color: Colors.deepOrange,
          fontSize: 30,
        ),
        ),
      ),
      backgroundColor: Color.fromRGBO(12, 48, 73, 1.0),
      body: ListView.builder(
          itemCount: searchPeople.length,
          itemBuilder: (context, index) {
            final get_searchPeople = searchPeople[index];
            var image_address = '';
            if((get_searchPeople.image_url) == null){
              image_address = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Question_mark.png/640px-Question_mark.png";

            }else{
              image_address = image_url_start + get_searchPeople.image_url;
            }
            return SingleChildScrollView(
                child: ListTile(
                  title: Row(
                    children: [
                      SizedBox(
                          width: 100,
                          child: ClipRRect(
                            child: Image.network(
                                image_address),
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                      Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(get_searchPeople.name, style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w600
                                ),),
                                SizedBox(
                                  height: 10,
                                ),



                              ],
                            ),
                          )
                      )
                    ],
                  ),
                )
            );
          }


      ),
    );
  }
}

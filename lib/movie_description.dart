import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/models/search_people_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login_app.dart';
import 'models/description_model.dart';
List favs_lst = [];


class GetDescription extends StatefulWidget {
  GetDescription(this.image_url, this.movie_id, this.title);
  final String image_url;
  final String movie_id;
  final String title;

  @override
  _GetDescriptionState createState() => _GetDescriptionState();
}

class _GetDescriptionState extends State<GetDescription> {
  final image_url_start = "https://www.themoviedb.org/t/p/w1280";
  final firestore = FirebaseFirestore.instance;
  var _description = [];
  bool clicked = false;

  void updateList() async{
    List current_favs = [];
    final firestore = FirebaseFirestore.instance;
    final favs = await firestore.collection("Users")
        .doc(username)
        .collection("fav_movies")
        .get();
    for (var x in favs.docs) {
      current_favs.add(x.data()['movie_name']);
    }
    favs_lst = current_favs;
  }


    void deleteMovies(String title) async {
      final del_favs = await firestore.collection("Users")
          .doc(username)
          .collection("fav_movies")
          .get();
      for (var x in del_favs.docs) {
        if(x.data()['movie_name'] == title){
          firestore.collection("Users")
              .doc(username)
              .collection("fav_movies").doc(x.id).delete();
        }
      }
    }

      void fetchSearchPeople() async {
        final response = await http.get(Uri.parse(
            "https://api.themoviedb.org/3/movie/ " +
                widget.movie_id +
                "?api_key=f717d34cc88a111bceead2fe8c1a9af8&language=en-US"));
        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);
          final lst = [];
          lst.add(result);
          if (favs_lst.contains(widget.title)) {
            clicked = true;
          } else {
            clicked = false;
          }

          setState(() {
            _description = lst;
          });
        } else {
          throw Exception("Error");
        }
      }


      @override
      void initState() {
        super.initState();
        fetchSearchPeople();
      }

      @override
      Widget build(BuildContext context) {
        updateList();
        return Scaffold(
          appBar: AppBar(
            backgroundColor:Color.fromRGBO(12, 48, 73, 1.0),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    clicked = !clicked;
                  if(clicked == true && favs_lst.length == 0){
                    firestore.collection("Users").doc(username).collection(
                        "fav_movies").add({
                      "movie_name": widget.title,
                      "movie_id":widget.movie_id,
                    });
                  }
                   else  if (clicked == true &&
                        favs_lst.contains(widget.title) == false) {
                      firestore.collection("Users").doc(username).collection(
                          "fav_movies").add({
                        "movie_name": widget.title,
                        "movie_id":widget.movie_id,
                      });
                    }
                    else if (clicked == false &&
                        favs_lst.contains(widget.title)) {
                      firestore.collection("Users").doc(username).collection(
                          "del_fav_movies").add({
                        "movie_name": widget.title,
                        "movie_id":widget.movie_id,
                      });
                      deleteMovies(widget.title);
                    }
                  });
                },
                icon: Icon((clicked == false) ?
                Icons.star_border : Icons.star_purple500_outlined, size: 30,
                ),
              )
            ],
            iconTheme: IconThemeData(
              color: Colors.deepOrange, //change your color here
            ),
            title: Text(
              "Movie Overview",
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 30,
              ),
            ),
          ),
          backgroundColor: Color.fromRGBO(12, 48, 73, 1.0),
          body: ListView.builder(
              itemCount: _description.length,
              itemBuilder: (context, index) {
                final get_description = _description[index];
                final vote_Average = get_description["vote_average"];
                final get_vote_average = "$vote_Average";
                var image_address = '';
                String genres = '';
                for (int i = 0; i < get_description["genres"].length; i++) {
                  genres += " " + get_description["genres"][i]["name"] + ",";
                }
                genres = genres.substring(0, genres.length - 1);

                String production_companies = '';
                for (int i = 0;
                i < get_description["production_companies"].length;
                i++) {
                  production_companies += " " +
                      get_description["production_companies"][i]["name"] +
                      ", ";
                }
                production_companies = production_companies.substring(
                    0, production_companies.length - 1);

                if ((get_description["backdrop_path"]) == null) {
                  image_address =
                  "https://upload.wikimedia.org/wikipedia/rcommons/thumb/a/af/Question_mark.png/640px-Question_mark.png";
                } else {
                  image_address = widget.image_url;
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 400.0,
                        width: 350.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(image_address),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            get_description["tagline"],
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Colors.deepOrange,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RichText(
                            text: new TextSpan(
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: 'Title: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.deepOrange,
                                    )),
                                new TextSpan(
                                  text: get_description["original_title"],
                                    style: TextStyle(
                                      color: Colors.white,
                                    )
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          RichText(
                            text: new TextSpan(
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: 'Language: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.deepOrange,
                                    )),
                                new TextSpan(
                                  text: get_description["original_language"],
                                    style: TextStyle(
                                      color: Colors.white,
                                    )
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          RichText(
                            text: new TextSpan(
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: 'Release Date: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.deepOrange,
                                    )),
                                new TextSpan(
                                  text: get_description["release_date"],
                                    style: TextStyle(
                                      color: Colors.white,
                                    )
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          RichText(
                            text: new TextSpan(
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: 'Genre:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.deepOrange,
                                    )),
                                new TextSpan(
                                  text: genres,
                                    style: TextStyle(
                                      color: Colors.white,
                                    )
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          RichText(
                            text: new TextSpan(
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: 'Score: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.deepOrange,
                                    )),
                                new TextSpan(
                                  text: get_vote_average,
                                    style: TextStyle(
                                      color: Colors.white,
                                    )
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          RichText(
                            text: new TextSpan(
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: 'Production:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.deepOrange,
                                    )),
                                new TextSpan(
                                  text: production_companies,
                                    style: TextStyle(
                                      color: Colors.white,
                                    )
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          RichText(
                            text: new TextSpan(
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                    text: 'Overview: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.deepOrange,
                                    )),
                                new TextSpan(
                                  text: get_description["overview"],
                                    style: TextStyle(
                                      color: Colors.white,
                                    )
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }),
        );
      }
    }

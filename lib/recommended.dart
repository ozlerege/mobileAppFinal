import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login_app.dart';
import 'models/search_model.dart';
import 'movie_description.dart';

class Recommended extends StatefulWidget {
  const Recommended({Key? key}) : super(key: key);

  @override
  _RecommendedState createState() => _RecommendedState();


}
//image url start = https://image.tmdb.org/t/p/w1280

class _RecommendedState extends State<Recommended> {
  List<dynamic> recommended = <MovieDatabase>[];
  final image_url_start = "https://image.tmdb.org/t/p/w1280";
  @override
  void initState() {
    super.initState();
    _populateAllMovies();
  }




  Future<List<dynamic>> fetchTrendings() async {
    List current_favs = [];
    final firestore = FirebaseFirestore.instance;
    final favs = await firestore.collection("Users")
        .doc(username)
        .collection("fav_movies")
        .get();
    for (var x in favs.docs) {
      current_favs.add(x.data()['movie_id']);
    }
    Random random = new Random();
    int randomMovieId = random.nextInt(current_favs.length);
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/"+ '${current_favs[randomMovieId]}' +"/recommendations?api_key=f717d34cc88a111bceead2fe8c1a9af8&language=en-US&page=1"));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["results"];
      return list.map((trending) => MovieDatabase.fromJson(trending)).toList();
    } else {
      throw Exception("Error");
    }
  }

  void _populateAllMovies() async {
    final _recommended = await fetchTrendings();
    setState(() {
      recommended = _recommended;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(12, 48, 73, 1.0),
        iconTheme: IconThemeData(
          color: Colors.deepOrange, //change your color here
        ),
        title: Text("Recommended",style: TextStyle(
          color: Colors.deepOrange,
          fontSize: 30,
        ),
        ),
      ),
      backgroundColor: Color.fromRGBO(12, 48, 73, 1.0),
      body: ListView.builder(
          itemCount: recommended.length,
          itemBuilder: (context, index){
            final get_recommended = recommended[index];
            final get_averageVote = get_recommended.vote_average;
            final get_voteCount = get_recommended.vote_count;
            final get_movieId = get_recommended.movie_id;
            final String movieId = "$get_movieId";
            return SingleChildScrollView(
                child: ListTile(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GetDescription(image_url_start + get_recommended.image_url,movieId,get_recommended.title))),
                  title: Row(
                    children: [
                      SizedBox(
                          width: 100,
                          child: ClipRRect(
                            child: Image.network(image_url_start + get_recommended.image_url),
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                      Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(get_recommended.title, style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w600
                                ),),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Release Date: " + get_recommended.release_date, style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Vote Average: " +  "$get_averageVote", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),),
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





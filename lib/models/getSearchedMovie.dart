import 'dart:convert';
import 'package:final_project/models/search_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../movie_description.dart';

class GetSearchedMovie extends StatefulWidget {
  GetSearchedMovie(this.url);
  final String url;

  @override
  _GetSearchedMovieState createState() => _GetSearchedMovieState();
}

class _GetSearchedMovieState extends State<GetSearchedMovie> {
  List<dynamic> searchMovie = <MovieDatabase>[];
  final image_url_start = "https://image.tmdb.org/t/p/w1280";

  @override
  void initState() {
    super.initState();
    _populateAllMovies();
  }


  Future<List<dynamic>> fetchTopRated() async {
    final response = await http.get(Uri.parse(widget.url));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["results"];
      return list.map((search_movie) => MovieDatabase.fromJson(search_movie))
          .toList();
    } else {
      throw Exception("Error");
    }
  }

  void _populateAllMovies() async {
    final _searchMovie = await fetchTopRated();
    setState(() {
      searchMovie = _searchMovie;
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
        title: Text("Results", style: TextStyle(
          color: Colors.deepOrange,
          fontSize: 30,
        ),
        ),
      ),
      backgroundColor: Color.fromRGBO(12, 48, 73, 1.0),
      body: ListView.builder(
          itemCount: searchMovie.length,
          itemBuilder: (context, index) {
            final get_searchMovie = searchMovie[index];
            final get_averageVote = get_searchMovie.vote_average;
            final get_voteCount = get_searchMovie.vote_count;
            final get_movieId = get_searchMovie.movie_id;
            final String movieId = "$get_movieId";
            var image_address = '';
            var release_date = '';
            if(get_searchMovie.release_date == null){
              release_date = "Not known";
            }else{
              release_date = get_searchMovie.release_date;
            }
            if((get_searchMovie.image_url) == null){
              image_address = "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Question_mark.png/640px-Question_mark.png";

            }else{
              image_address = image_url_start + get_searchMovie.image_url;
            }
            return SingleChildScrollView(
                child: ListTile(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GetDescription(image_url_start + get_searchMovie.image_url,movieId,get_searchMovie.title))),
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
                                Text(get_searchMovie.title, style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w600
                                ),),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Release Date: " +
                                    release_date,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Vote Average: " + "$get_averageVote",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Vote Count: " + "$get_voteCount",
                                  style: TextStyle(
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

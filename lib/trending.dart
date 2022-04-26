import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/search_model.dart';
import 'movie_description.dart';

class Trending extends StatefulWidget {
  const Trending({Key? key}) : super(key: key);

  @override
  _TrendingState createState() => _TrendingState();


}
//image url start = https://image.tmdb.org/t/p/w1280

class _TrendingState extends State<Trending> {
  List<dynamic> trending = <MovieDatabase>[];
  final image_url_start = "https://image.tmdb.org/t/p/w1280";
  @override
  void initState() {
    super.initState();
    _populateAllMovies();
  }


  Future<List<dynamic>> fetchTrendings() async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/trending/movie/week?api_key=f717d34cc88a111bceead2fe8c1a9af8"));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["results"];
      return list.map((trending) => MovieDatabase.fromJson(trending)).toList();
    } else {
      throw Exception("Error");
    }
  }

  void _populateAllMovies() async {
    final _trending = await fetchTrendings();
    setState(() {
      trending = _trending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(12, 48, 73, 1.0),
      body: ListView.builder(
          itemCount: trending.length,
          itemBuilder: (context, index){
            final get_trend = trending[index];
            final get_averageVote = get_trend.vote_average;
            final get_movieId = get_trend.movie_id;
            final String movieId = "$get_movieId";
            return SingleChildScrollView(
                child: ListTile(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GetDescription(image_url_start + get_trend.image_url,movieId,get_trend.title))),
                  title: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: ClipRRect(
                          child: Image.network(image_url_start + get_trend.image_url),
                          borderRadius: BorderRadius.circular(10),
                        )
                      ),
                      Flexible(
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(get_trend.title, style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontSize: 27,
                                      fontWeight: FontWeight.w600
                                  ),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Release Date: " + get_trend.release_date, style: TextStyle(
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





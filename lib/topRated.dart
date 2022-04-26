import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/search_model.dart';
import 'movie_description.dart';




class TopRated extends StatefulWidget {
  const TopRated({Key? key}) : super(key: key);

  @override
  _TopRatedState createState() => _TopRatedState();


}

class _TopRatedState extends State<TopRated> {
  List<dynamic> topRated = <MovieDatabase>[];
  final image_url_start = "https://image.tmdb.org/t/p/w1280";
  @override
  void initState() {
    super.initState();
    _populateAllMovies();
  }


  Future<List<dynamic>> fetchTopRated() async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=f717d34cc88a111bceead2fe8c1a9af8&language=en-US&page=1"));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["results"];
      return list.map((top_rated) => MovieDatabase.fromJson(top_rated)).toList();
    } else {
      throw Exception("Error");
    }
  }

  void _populateAllMovies() async {
    final _topRated = await fetchTopRated();
    setState(() {
      topRated = _topRated;
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
        title: Text("Top Rated",style: TextStyle(
          color: Colors.deepOrange,
          fontSize: 30,
        ),
        ),
      ),
      backgroundColor: Color.fromRGBO(12, 48, 73, 1.0),
      body: ListView.builder(
          itemCount: topRated.length,
          itemBuilder: (context, index){
            final get_topRated = topRated[index];
            final get_averageVote = get_topRated.vote_average;
            final get_voteCount = get_topRated.vote_count;
            final get_movieId = get_topRated.movie_id;
            final String movieId = "$get_movieId";
            return SingleChildScrollView(
                child: ListTile(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GetDescription(image_url_start + get_topRated.image_url,movieId,get_topRated.title))),
                  title: Row(
                    children: [
                      SizedBox(
                          width: 100,
                          child: ClipRRect(
                            child: Image.network(image_url_start + get_topRated.image_url),
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                      Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(get_topRated.title, style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 27,
                                    fontWeight: FontWeight.w600
                                ),),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Release Date: " + get_topRated.release_date, style: TextStyle(
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
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Vote Count: " +  "$get_voteCount", style: TextStyle(
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





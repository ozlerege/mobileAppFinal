import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/search_model.dart';
import 'movie_description.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  List<dynamic> nowPlaying = <MovieDatabase>[];
  final image_url_start = "https://image.tmdb.org/t/p/w1280";
  @override
  void initState() {
    super.initState();
    _populateAllMovies();
  }

  Future<List<dynamic>> fetchNowPlaying() async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=f717d34cc88a111bceead2fe8c1a9af8&language=en-US&page=1"));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["results"];
      return list
          .map((now_plaing) => MovieDatabase.fromJson(now_plaing))
          .toList();
    } else {
      throw Exception("Error");
    }
  }

  void _populateAllMovies() async {
    final _nowPlaying = await fetchNowPlaying();
    setState(() {
      nowPlaying = _nowPlaying;
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
        title: Text(
          "Now Playing",
          style: TextStyle(
            color: Colors.deepOrange,
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(12, 48, 73, 1.0),
      body: ListView.builder(
          itemCount: nowPlaying.length,
          itemBuilder: (context, index) {
            final get_nowPlaying = nowPlaying[index];
            final get_averageVote = get_nowPlaying.vote_average;
            final get_movieId = get_nowPlaying.movie_id;
            final String movieId = "$get_movieId";
            return SingleChildScrollView(
                child: ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GetDescription(
                          image_url_start + get_nowPlaying.image_url,
                          movieId,
                          get_nowPlaying.title))),
              title: Row(
                children: [
                  SizedBox(
                      width: 100,
                      child: ClipRRect(
                        child: Image.network(
                            image_url_start + get_nowPlaying.image_url),
                        borderRadius: BorderRadius.circular(10),
                      )),
                  Flexible(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          get_nowPlaying.title,
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 27,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Release Date: " + get_nowPlaying.release_date,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Vote Average: " + "$get_averageVote",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ));
          }),
    );
  }
}

class MovieDatabase{
  final String title;
  final  image_url;
  final String? release_date;
  final vote_average;
  final int vote_count;
  final movie_id;


  MovieDatabase({required this.title,required this.image_url, required this.release_date, required this.vote_average, required this.vote_count, required this.movie_id});

  factory MovieDatabase.fromJson(Map<String, dynamic> json){
    return MovieDatabase(
      title: json["title"],
      image_url: json["poster_path"],
      release_date:json["release_date"],
      vote_average: json["vote_average"],
      vote_count: json["vote_count"],
      movie_id: json["id"],


    );
  }
}
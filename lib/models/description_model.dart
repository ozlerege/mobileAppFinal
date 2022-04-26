class Description{
  final String title;
  final  image_url;
  final String release_date;
  final vote_average;
  final int vote_count;
  final String overview;
  final String language;
  final String tagline;


  Description({required this.title,required this.image_url,
    required this.release_date, required this.vote_average,
    required this.vote_count, required this.overview,
    required this.language, required this.tagline});

  factory Description.fromJson(Map<String, dynamic> json){
    return Description(
      title: json["title"],
      image_url: json["poster_path"],
      release_date:json["release_date"],
      vote_average: json["vote_average"],
      vote_count: json["vote_count"],
      overview: json["overview"],
      language: json["original_language"],
      tagline: json["tagline"]


    );
  }
}
class Search_People{
  final String name;
  final image_url;



  Search_People({required this.name,required this.image_url});

  factory Search_People.fromJson(Map<String, dynamic> json){
    return Search_People(
      name: json["name"],
      image_url: json["profile_path"],
    );
  }
}
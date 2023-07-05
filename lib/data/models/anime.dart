class Anime {
  int id;
  String title;
  String imageUrl;
  int? year;
  bool isFavorite;
  int? episodes;
  int? members;

  Anime({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.year,
    required this.isFavorite,
    required this.episodes,
    required this.members,
  });

  factory Anime.fromJson(Map<String, dynamic> json) => Anime(
        id: json['mal_id'],
        title: json['title'],
        imageUrl: json['images']['jpg']['image_url'],
        year: json['year'],
        isFavorite: false,
        episodes: json['episodes'],
        members: json['members'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image_url': imageUrl,
      'year': year,
      'is_favorite': 1,
    };
  }

  factory Anime.fromDbMap(Map<String, dynamic> map) => Anime(
        id: map['id'],
        title: map['title'],
        imageUrl: map['image_url'],
        year: map['year'],
        isFavorite: map['is_favorite'] == 1 ? true : false,
        episodes: 0,
        members: 0,
      );
}

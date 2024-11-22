class PokemonCard {
  final String id;
  final String name;
  final String imageUrl;
  final List<dynamic>? attacks;
  final List<dynamic>? weaknesses;
  final String? artist;

  PokemonCard({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.attacks,
    this.weaknesses,
    this.artist,
  });

  factory PokemonCard.fromJson(Map<String, dynamic> json) {
    return PokemonCard(
      id: json['id'],
      name: json['name'],
      imageUrl: json['images']['small'],
      attacks: json['attacks'],
      weaknesses: json['weaknesses'],
      artist: json['artist'],
    );
  }
}

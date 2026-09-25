class PokemonModel {
  final int id;
  final String name;
  final String image;
  final String audio;

  PokemonModel({
    required this.id,
    required this.name,
    required this.image,
    required this.audio,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'],
      name: json['name'],
      image: json['sprites']['other']['official-artwork']
              ['front_default'] ??
          '',
      audio: json['cries']['latest'] ?? '',
    );
  }
}

class Persona {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;

  // Para no complicar con clases extra, guardamos origin/location como String
  final String originName;
  final String locationName;

  // Número de episodios (la API trae lista de URLs)
  final int episodeCount;

  Persona({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.originName,
    required this.locationName,
    required this.episodeCount,
  });

  factory Persona.fromJson(Map<String, dynamic> json) {
    final origin = json['origin'];
    final location = json['location'];
    final episode = json['episode'];

    return Persona(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      species: json['species'] ?? '',
      gender: json['gender'] ?? '',
      image: json['image'] ?? '',
      originName: (origin is Map && origin['name'] != null) ? origin['name'] : '',
      locationName: (location is Map && location['name'] != null) ? location['name'] : '',
      episodeCount: (episode is List) ? episode.length : 0,
    );
  }
}

class Persona {
  final String nom;
  final String cognom;
  final DateTime dataNaixement;
  final String correu;
  final String contrasenya;

  const Persona({
    required this.nom,
    required this.cognom,
    required this.dataNaixement,
    required this.correu,
    required this.contrasenya,
  });

  // Valors per defecte (per enviar des de HomePage)
  factory Persona.defaultValues() {
    return Persona(
      nom: "Nom",
      cognom: "Cognom",
      dataNaixement: DateTime(2000, 1, 1),
      correu: "exemple@demo.com",
      contrasenya: "1234",
    );
  }

  String get nomComplet => "$nom $cognom";
}

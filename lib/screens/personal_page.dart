import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/persona.dart';

class PersonalPage extends StatelessWidget {
  final int personaId;
  const PersonalPage({super.key, required this.personaId});

  Future<Persona> _fetchPersonaDetail(int id) async {
    final uri = Uri.parse('https://rickandmortyapi.com/api/character/$id');
    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('Error HTTP ${res.statusCode}: ${res.body}');
    }

    final data = jsonDecode(res.body) as Map<String, dynamic>;
    return Persona.fromJson(data);
  }

  Widget _row(String k, String v) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            SizedBox(
              width: 90,
              child: Text('$k:', style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(child: Text(v)),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle')),
      body: FutureBuilder<Persona>(
        future: _fetchPersonaDetail(personaId),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) return Center(child: Text('Error: ${snap.error}'));

          final p = snap.data!;
          return ListView(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  p.image,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Center(child: Icon(Icons.broken_image, size: 48)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.name, style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 12),
                    _row('Status', p.status),
                    _row('Species', p.species),
                    _row('Gender', p.gender),
                    _row('Origin', p.originName),
                    _row('Location', p.locationName),
                    _row('Episodes', '${p.episodeCount}'),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

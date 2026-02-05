import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../models/persona.dart';
import 'personal_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Persona>> _future;

  @override
  void initState() {
    super.initState();
    _future = _fetchPersonas(page: 1);
  }

  Future<List<Persona>> _fetchPersonas({int page = 1}) async {
    final uri = Uri.parse('https://rickandmortyapi.com/api/character?page=$page');
    final res = await http.get(uri);

    if (res.statusCode != 200) {
      throw Exception('Error HTTP ${res.statusCode}: ${res.body}');
    }

    final data = jsonDecode(res.body) as Map<String, dynamic>;
    final results = data['results'] as List<dynamic>;

    return results
        .map((e) => Persona.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  void _openDetail(Persona p) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PersonalPage(personaId: p.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick and Morty (PF3)'),
      ),
      body: FutureBuilder<List<Persona>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final personas = snapshot.data ?? [];
          if (personas.isEmpty) {
            return const Center(child: Text('Sin datos'));
          }

          final swiperItems = personas.take(10).toList();
          final sliderItems = personas.skip(10).take(10).toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 12),

                // -------------------------
                // CardSwiper (obligatorio)
                // -------------------------
                SizedBox(
                  height: 420,
                  child: CardSwiper(
                    cardsCount: swiperItems.length,
                    cardBuilder: (context, index, _, __) {
                      final p = swiperItems[index];
                      return InkWell(
                        onTap: () => _openDetail(p),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                p.image,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        size: 48,
                                      ),
                                    ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  color: Colors.black54,
                                  child: Text(
                                    p.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Más personajes',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // -------------------------
                // CarouselView (slider)
                // -------------------------
                SizedBox(
                  height: 220,
                  child: CarouselView(
                    itemExtent: 260,
                    shrinkExtent: 240,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    children: sliderItems.map((p) {
                      return GestureDetector(
                        onTap: () => _openDetail(p),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                p.image,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const Center(
                                      child: Icon(
                                        Icons.broken_image,
                                        size: 48,
                                      ),
                                    ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  color: Colors.black54,
                                  child: Text(
                                    p.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}

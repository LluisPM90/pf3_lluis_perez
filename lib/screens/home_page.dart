import 'package:flutter/material.dart';
import '../models/persona.dart';
import 'personal_page.dart';
import 'widget_page.dart';

class HomePage extends StatefulWidget {
  // Stateful: perquè hem d'actualitzar la UI quan rebem la Persona retornada.
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Persona? _personaRebuda;

  Future<void> _anarAPersonal() async {
    final personaInicial = Persona.defaultValues();

    // push() retorna un Future. Quan la pantalla fa pop(persona), aquí la rebem.
    final resultat = await Navigator.push<Persona>(
      context,
      MaterialPageRoute(
        builder: (_) => PersonalPage(personaInicial: personaInicial),
      ),
    );

    if (resultat != null) {
      setState(() => _personaRebuda = resultat);
    }
  }

  void _anarAWidgets() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const WidgetPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textResultat = (_personaRebuda == null)
        ? "Encara no has editat cap persona."
        : "Persona rebuda: ${_personaRebuda!.nomComplet}";

    return Scaffold(
      appBar: AppBar(title: const Text("PF2")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Benvingut/da a la PF2",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12),
              Text(textResultat, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _anarAPersonal,
                child: const Text("Anar a PersonalPage"),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: _anarAWidgets,
                child: const Text("Anar a WidgetPage"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

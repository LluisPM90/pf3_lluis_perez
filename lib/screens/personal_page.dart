import 'package:flutter/material.dart';
import '../models/persona.dart';

class PersonalPage extends StatefulWidget {
  // Stateful: perquè gestionam TextEditingControllers, validació i selecció de data.
  final Persona personaInicial;

  const PersonalPage({super.key, required this.personaInicial});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nomCtrl;
  late final TextEditingController _cognomCtrl;
  late final TextEditingController _correuCtrl;
  late final TextEditingController _passCtrl;

  late DateTime _dataNaixement;

  @override
  void initState() {
    super.initState();
    final p = widget.personaInicial;
    _nomCtrl = TextEditingController(text: p.nom);
    _cognomCtrl = TextEditingController(text: p.cognom);
    _correuCtrl = TextEditingController(text: p.correu);
    _passCtrl = TextEditingController(text: p.contrasenya);
    _dataNaixement = p.dataNaixement;
  }

  @override
  void dispose() {
    _nomCtrl.dispose();
    _cognomCtrl.dispose();
    _correuCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  String _formatData(DateTime d) =>
      "${d.day.toString().padLeft(2, '0')}/"
      "${d.month.toString().padLeft(2, '0')}/"
      "${d.year}";

  Future<void> _triarData() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dataNaixement,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => _dataNaixement = picked);
    }
  }

  void _desar() {
    if (_formKey.currentState?.validate() != true) return;

    final personaModificada = Persona(
      nom: _nomCtrl.text.trim(),
      cognom: _cognomCtrl.text.trim(),
      dataNaixement: _dataNaixement,
      correu: _correuCtrl.text.trim(),
      contrasenya: _passCtrl.text,
    );

    // Retornam l'objecte a la HomePage
    Navigator.pop(context, personaModificada);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pérez")), // posa aquí el teu cognom
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomCtrl,
                decoration: const InputDecoration(labelText: "Nom"),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? "Introdueix el nom" : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _cognomCtrl,
                decoration: const InputDecoration(labelText: "Cognom"),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? "Introdueix el cognom"
                    : null,
              ),
              const SizedBox(height: 12),

              // Data de naixement (camp “fake” + botó)
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Data de naixement",
                  border: OutlineInputBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_formatData(_dataNaixement)),
                    TextButton(
                      onPressed: _triarData,
                      child: const Text("Canvia"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),
              TextFormField(
                controller: _correuCtrl,
                decoration: const InputDecoration(labelText: "Correu electrònic"),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  final text = (v ?? "").trim();
                  if (text.isEmpty) return "Introdueix el correu";
                  if (!text.contains("@")) return "Format de correu incorrecte";
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passCtrl,
                decoration: const InputDecoration(labelText: "Contrasenya"),
                obscureText: true,
                validator: (v) =>
                    (v == null || v.length < 4) ? "Mínim 4 caràcters" : null,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _desar,
                child: const Text("Desa"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

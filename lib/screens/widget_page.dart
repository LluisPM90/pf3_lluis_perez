import 'package:flutter/material.dart';

class WidgetPage extends StatefulWidget {
  const WidgetPage({super.key});

  @override
  State<WidgetPage> createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  final List<String> _itemsDismissible = [
    "Correcció ortogràfica",
    "Afegir validacions",
    "Provar navegació",
    "Preparar vídeo",
  ];

  final List<String> _itemsReorder = [
    "Estudiar Flutter",
    "Fer el formulari",
    "Provar navegació",
    "Gravar vídeo (max 5 min)",
  ];

  void _showMsg(String text) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Etiquetes")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              "Widget 1: Etiquetes: (llisca per eliminar)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Llista 1: Eliminar etiqueta lliscant
            ..._itemsDismissible.map((t) {
              return Dismissible(
                key: ValueKey(t),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.redAccent,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) {
                  setState(() => _itemsDismissible.remove(t));
                  _showMsg("Eliminat: $t");
                },
                child: Card(
                  child: ListTile(
                    title: Text(t),
                    subtitle: const Text("Fes swipe cap a l'esquerra"),
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),
            const Text(
              "Widget 2: ReorderableListView (arrossega per reordenar)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Llista 2: ReorderableListView
            SizedBox(
              height: 260,
              child: ReorderableListView.builder(
                buildDefaultDragHandles:
                    false, // IMPORTANT: desactivam el long-press per defecte
                itemCount: _itemsReorder.length,
                itemBuilder: (context, index) {
                  final text = _itemsReorder[index];
                  return ListTile(
                    key: ValueKey(text),
                    title: Text(text),
                    leading: ReorderableDragStartListener(
                      index: index,
                      child: const Icon(Icons.drag_handle),
                    ),
                  );
                },
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex--;
                    final item = _itemsReorder.removeAt(oldIndex);
                    _itemsReorder.insert(newIndex, item);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

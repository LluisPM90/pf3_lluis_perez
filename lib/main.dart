import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const Pf2App());
}

class Pf2App extends StatelessWidget {
  // Stateless: no manté estat intern; només configura l'app.
  const Pf2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PF2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

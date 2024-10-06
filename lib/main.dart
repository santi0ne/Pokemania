import 'package:flutter/material.dart';

import 'features/pokemons_evo/presentation/pages/PokemonListPage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pokemania App",
      home: PokemonListPage()
    );
  }
}

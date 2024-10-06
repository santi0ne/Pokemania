import 'package:flutter/material.dart';
import '../widgets/PokeFloatingButton.dart';

import '../widgets/PokeAppBar.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  @override
  Widget build(Object context) {
    return const Scaffold(
      appBar: PokeAppBar(),
      floatingActionButton: PokeFloatingButton(),
    );
  }
}
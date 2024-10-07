import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/pokemons_evo/data/repositories/pokemon_repository_impl.dart';
import 'features/pokemons_evo/domain/usecases/get_pokemon_details.dart';
import 'features/pokemons_evo/domain/usecases/get_pokemon_list.dart';
import 'features/pokemons_evo/presentation/bloc/pokemon_app_bloc.dart';
import 'features/pokemons_evo/presentation/pages/pokemon_list_page.dart';

void main() {
  final getIt = GetIt.instance;
  getIt.registerLazySingleton<PokemonRepositoryImpl>(() => PokemonRepositoryImpl());
  getIt.registerLazySingleton(() => GetPokemonList(repository: getIt<PokemonRepositoryImpl>()));
  getIt.registerLazySingleton(() => GetPokemonDetails(repository: getIt<PokemonRepositoryImpl>()));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pokemania App",
      home: BlocProvider(
        create: (context) => PokemonAppBloc(
          getPokemonList: GetIt.I<GetPokemonList>(),
          getPokemonDetails: GetIt.I<GetPokemonDetails>(),
        ),
        child: const PokemonListPage(),
      )
    );
  }
}

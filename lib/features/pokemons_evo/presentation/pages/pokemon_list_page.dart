import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemania/features/pokemons_evo/presentation/pages/pokemon_details_page.dart';
import 'package:pokemania/features/pokemons_evo/presentation/widgets/pokemon_grid_item.dart';
import '../bloc/pokemon_app_bloc.dart';
import '../widgets/pokemon_floating_button.dart';

import '../widgets/poke_app_bar.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: const PokeAppBar(),
      floatingActionButton: const PokeFloatingButton(),
      body: BlocProvider(
        create: (context) => context.read<PokemonAppBloc>()
        ..add(GetPokemonListEvent()),
        child: BlocBuilder<PokemonAppBloc, PokemonAppState>(
          builder: (context, state) {
            if (state is PokemonLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PokemonLoadedState) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 3 / 2
                ), 
                padding: const EdgeInsets.all(10.0),
                itemCount: state.pokemons.length,
                itemBuilder: (context, index) {  
                  final pokemon = state.pokemons[index];
                  return PokemonGridItem(
                    pokemon: pokemon, 
                    onTap: () {
                      // navigate to pokemon details page
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => PokemonDetailsPage(pokemonId: pokemon.id),
                        ),
                      );
                    },
                  );
                },
                );
            } else if (state is PokemonErrorState) {
              return Center(child: Text(state.failure.message),);
            }
            return const Center(child: Text('Cargando...'),);
          },
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemania/features/pokemons_evo/presentation/bloc/pokemon_app_bloc.dart';

class PokemonDetailsPage extends StatelessWidget {
  final int pokemonId;

  const PokemonDetailsPage({
    super.key, 
    required this.pokemonId
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => context.read<PokemonAppBloc>()
        ..add(GetPokemonDetailsEvent(pokemonId)),
        child: BlocBuilder<PokemonAppBloc, PokemonAppState>(
          builder: (context, state) {
            if (state is PokemonLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PokemonDetailsLoadedState) {
              final pokemon = state.pokemon;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(pokemon.imageUrl),
                    Text(
                      'Nombre: ${pokemon.name}',
                      style: const TextStyle(fontSize: 24)
                    ),
                    const SizedBox(height: 8),
                    Text('Tipos: ${pokemon.types.join(", ")}'),
                    const SizedBox(height: 8),
                    Text('Habilidades: ${pokemon.abilities.join(", ")}'),
                    const SizedBox(height: 8),
                    const Text('Estadisticas:'),
                    Text('HP: ${pokemon.stats['hp']}'),
                    Text('Ataque: ${pokemon.stats['attack']}'),
                    Text('Defensa: ${pokemon.stats['defense']}'),
                    const SizedBox(height: 16),

                    // show next evolution
                    if (pokemon.evolutions.isNotEmpty && pokemon.evolutions[0].name != 'No tiene mas evoluciones')
                      Text('Próxima evolución: ${pokemon.evolutions[0].name}')
                    else if (pokemon.evolutions.isNotEmpty && pokemon.evolutions[0].name == 'No tiene más evoluciones')
                      const Text('Este Pokémon no tiene más evoluciones')
                  ],
                ),
              );
            } else if (state is PokemonErrorState) {
              return Center(child: Text(state.failure.message));
            }
            return const Center(child: Text('Cargando...'));
          }
        ),
      ),
    );
  }
}
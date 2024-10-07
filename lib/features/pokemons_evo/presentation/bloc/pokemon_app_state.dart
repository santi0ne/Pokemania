part of 'pokemon_app_bloc.dart';

@immutable
sealed class PokemonAppState {}

class PokemonInitialState extends PokemonAppState {}

class PokemonLoadingState extends PokemonAppState {}

class PokemonLoadedState extends PokemonAppState {
  final List<Pokemon> pokemons;

  PokemonLoadedState(this.pokemons);
}

class PokemonDetailsLoadedState extends PokemonAppState {
  final Pokemon pokemon;

  PokemonDetailsLoadedState(this.pokemon);
}

class PokemonErrorState extends PokemonAppState {
  final Failure failure;

  PokemonErrorState(this.failure);
}

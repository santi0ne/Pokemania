part of 'pokemon_app_bloc.dart';

@immutable
sealed class PokemonAppEvent {}

class GetPokemonListEvent extends PokemonAppEvent {}

class GetPokemonDetailsEvent extends PokemonAppEvent {
  final int id;

  GetPokemonDetailsEvent(this.id);
}
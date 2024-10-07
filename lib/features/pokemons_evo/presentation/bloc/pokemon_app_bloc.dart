import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokemania/features/pokemons_evo/domain/usecases/get_pokemon_list.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/usecases/get_pokemon_details.dart';

part 'pokemon_app_event.dart';
part 'pokemon_app_state.dart';

class PokemonAppBloc extends Bloc<PokemonAppEvent, PokemonAppState> {
  final GetPokemonList getPokemonList;
  final GetPokemonDetails getPokemonDetails;

  PokemonAppBloc({
    required this.getPokemonList,
    required this.getPokemonDetails,
  }) : super(PokemonInitialState()){

    // handler to GetPokemonListEvent
    on<GetPokemonListEvent>((event, emit) async {
      emit(PokemonLoadingState());
      final result = await getPokemonList();
      result.fold(
        (failure) => emit(PokemonErrorState(failure)),
        (pokemons) => emit(PokemonLoadedState(pokemons))
      );
    });

    // handler to GetPokemonDetailsEvent
    on<GetPokemonDetailsEvent>((event, emit) async {
      emit(PokemonLoadingState());
      final result = await getPokemonDetails(event.id);
      result.fold(
        (failure) => emit(PokemonErrorState(failure)), 
        (pokemon) => emit(PokemonDetailsLoadedState(pokemon))
      );
    });
  }
}
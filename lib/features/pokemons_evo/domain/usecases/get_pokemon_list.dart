import 'package:dartz/dartz.dart';
import 'package:pokemania/features/pokemons_evo/domain/repositories/pokemon_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon.dart';

class GetPokemonList {
  final PokemonRepository repository;

  GetPokemonList({required this.repository});

  Future<Either<Failure, List<Pokemon>>> call() async {
    return await repository.getPokemonList();
  }

}
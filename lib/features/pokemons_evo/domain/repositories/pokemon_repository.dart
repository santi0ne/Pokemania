import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon.dart';
import '../entities/pokemon_evolution.dart';

abstract class PokemonRepository {
  Future<Either<Failure, List<Pokemon>>> getPokemonList();
  Future<Either<Failure,Pokemon>> getPokemonDetails(int id);
  Future<PokemonEvolution> parseEvolutions(Map<String, dynamic> chain, String currentPokemonName);
}
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonDetails {
  final PokemonRepository repository;

  GetPokemonDetails({required this.repository});

  Future<Either<Failure, Pokemon>> call(int id) async {
    return await repository.getPokemonDetails(id);
  } 
}
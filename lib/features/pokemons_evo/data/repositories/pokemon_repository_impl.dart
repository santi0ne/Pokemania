import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:pokemania/features/pokemons_evo/data/models/pokemon_model.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_evolution.dart';
import '../../domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final String apiUrl = "https://pokeapi.co/api/v2";

  // get first 20 pokemons
  @override
  Future<Either<Failure, List<Pokemon>>> getPokemonList() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/pokemon?limit=20'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List results = data['results'];

        List<Pokemon> pokemonList = [];
        for (var result in results) {
          final eitherPokemon =
              await _fetchPokemonDetailsFromUrl(result['url']);
          eitherPokemon.fold(
            (failure) => null,
            (pokemon) => pokemonList.add(pokemon),
          );
        }
        return Right(pokemonList);
      } else {
        return Left(Failure(message: 'Error al obtener la lista de Pokémon'));
      }
    } catch (e) {
      return Left(Failure(message: "Error de conexion: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemonDetails(int id) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/pokemon/$id'));
      if (response.statusCode == 200) {
        final pokemonData = json.decode(response.body);
        Pokemon pokemon = PokemonModel.fromJson(pokemonData);

        // get pokemon evolutions
        final speciesResponse =
            await http.get(Uri.parse(pokemonData['species']['url']));
        if (speciesResponse.statusCode == 200) {
          final speciesData = json.decode(speciesResponse.body);
          final evolutionChainUrl = speciesData['evolution_chain']['url'];

          final evolutionResponse =
              await http.get(Uri.parse(evolutionChainUrl));
          if (evolutionResponse.statusCode == 200) {
            final evolutionData = json.decode(evolutionResponse.body);
            final evolution = await parseEvolutions(evolutionData['chain'], pokemon.name);
            pokemon = Pokemon(
              id: pokemon.id,
              name: pokemon.name,
              imageUrl: pokemon.imageUrl,
              types: pokemon.types,
              abilities: pokemon.abilities,
              stats: pokemon.stats,
              evolutions: [evolution],
            );
          }
        }
        return Right(pokemon);
      } else {
        return Left(Failure(message: 'Error al obtener detalles del Pokémon'));
      }
    } catch (e) {
      return Left(Failure(message: 'Error de conexión: ${e.toString()}'));
    }
  }

  @override
  Future<PokemonEvolution> parseEvolutions(Map<String, dynamic> chain, String currentPokemonName) async {
    try {
      // actual pokemon
      Map<String, dynamic>? currentEvolution = chain;

      // iterate to find current pokemon in evolutive chain
      while (currentEvolution != null && currentEvolution['species']['name'] != currentPokemonName) {
        if (currentEvolution['evolves_to'].isNotEmpty) {
          currentEvolution = currentEvolution['evolves_to'][0]; // next chain
        } else {
          currentEvolution = null;  // no more evolutions, loop ends!
        }
      }

      // if we found current poke on, return next evolution
      if (currentEvolution != null && currentEvolution['evolves_to'].isNotEmpty) {
        final nextEvolution = currentEvolution['evolves_to'][0];  // next evolution
        return PokemonEvolution(
          name: nextEvolution['species'], 
          imageUrl: ''  // no implemented yet
        );
      } else {
        // if theres no more evolutions, return a message
        return PokemonEvolution(
          name: 'No tiene mas evoluciones', 
          imageUrl: '');
      }
    } catch (e) {
      throw Failure(message: "Error al obtener siguiente evolucion: ${e.toString()}");
    }
  }

// get details of a pokemon from url
  Future<Either<Failure, Pokemon>> _fetchPokemonDetailsFromUrl(
      String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final pokemonData = json.decode(response.body);
        return Right(PokemonModel.fromJson(pokemonData));
      } else {
        return Left(Failure(message: 'Error al obtener detalles del Pokémon'));
      }
    } catch (e) {
      return Left(Failure(message: 'Error de conexión: ${e.toString()}'));
    }
  }
}

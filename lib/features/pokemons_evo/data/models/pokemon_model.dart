import 'package:pokemania/features/pokemons_evo/domain/entities/pokemon.dart';

import '../../domain/entities/pokemon_evolution.dart';

class PokemonModel extends Pokemon {
  PokemonModel({required super.id, required super.name, required super.imageUrl, required super.types, required super.abilities, required super.stats, required super.evolutions});

  factory PokemonModel.fromJson(Map<String, dynamic> json) {

    List<String> types = (json['types'] as List)
    .map((typeInfo) => typeInfo['type']['name'] as String)
    .toList();

    List<String> abilities = (json['abilities'] as List)
    .map((abilityInfo) => abilityInfo['ability']['name'] as String)
    .toList();

    Map<String, int> stats = {
      'hp': json['stats'][0]['base_stat'],
      'attack': json['stats'][1]['base_stat'],
      'defense': json['stats'][2]['base_stat'],
    };

    List<PokemonEvolution> evolutions = [];  // modelo factory  de evoluciones

    return PokemonModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['sprites']['front_default'],
      types: types,
      abilities: abilities,
      stats: stats,
      evolutions: evolutions,
    );

  }

}
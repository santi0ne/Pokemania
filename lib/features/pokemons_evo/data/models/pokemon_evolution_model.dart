import '../../domain/entities/pokemon_evolution.dart';

class PokemonEvolutionModel extends PokemonEvolution {
  PokemonEvolutionModel({required super.name, required super.imageUrl});

  factory PokemonEvolutionModel.fromJson(Map<String, dynamic> json) {
    return PokemonEvolutionModel(
        name: json['species']['name'],
        imageUrl: json['sprites']['front_default']);
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pokemon_model.dart';

class PokemonService {
  static const String baseUrl =
      'https://pokeapi.co/api/v2/pokemon';

  Future<PokemonModel> buscarPokemon(
    dynamic busca,
  ) async {
    final resposta = await http.get(
      Uri.parse('$baseUrl/$busca'),
    );

    if (resposta.statusCode != 200) {
      throw Exception(
        'Pokémon não encontrado',
      );
    }

    final dados = jsonDecode(resposta.body);

    return PokemonModel.fromJson(dados);
  }
}

import 'package:dio/dio.dart';
import 'package:pokemon_app/core/core.dart' show DioClient;
import 'package:pokemon_app/features/pokemon/data/data.dart'
    show PokemonModel, PokemonRemoteDatasource;

class PokemonRemoteDatasourceImpl implements PokemonRemoteDatasource {
  PokemonRemoteDatasourceImpl(this._dioClient);

  final DioClient _dioClient;
  static const String _endpoint = 'pokemon/';

  @override
  Future<List<PokemonModel>> getPokemonList({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await _dioClient.dio.get<Map<String, dynamic>>(
        '$_endpoint?limit=$limit&offset=$offset',
      );

      final results = response.data!['results'] as List<dynamic>;

      return results.map((pokemon) {
        final url = pokemon['url'] as String;

        // https://pokeapi.co/api/v2/pokemon/1/
        final id = int.parse(url.split('/')[6]);

        return PokemonModel(
          id: id,
          name: pokemon['name'] as String,
          imageUrl:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
          height: 0,
          weight: 0,
          hp: 0,
          attack: 0,
          defense: 0,
          specialAttack: 0,
          specialDefense: 0,
          speed: 0,
        );
      }).toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch Pokémon list: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error while fetching Pokémon list: $e');
    }
  }

  @override
  Future<PokemonModel> getPokemonDetail(int id) async {
    try {
      final response = await _dioClient.dio.get<Map<String, dynamic>>(
        '$_endpoint$id',
      );

      return PokemonModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw Exception('Failed to fetch Pokémon detail: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error while fetching Pokémon detail: $e');
    }
  }
}

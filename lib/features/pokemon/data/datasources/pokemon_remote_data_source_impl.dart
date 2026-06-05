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

      return results.map((e) => PokemonModel.fromListResult(e as Map<String, dynamic>)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to fetch Pokémon list: ${e.message}');
    }
  }

  @override
  Future<PokemonModel> getPokemonDetail(int id) async {
    try {
      final response = await _dioClient.dio.get<Map<String, dynamic>>(
        '$_endpoint$id',
      );

      return PokemonModel.fromApi(response.data!);
    } on DioException catch (e) {
      throw Exception('Failed to fetch Pokémon detail: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error while fetching Pokémon detail: $e');
    }
  }
}

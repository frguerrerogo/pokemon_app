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

      final pokemons = <PokemonModel>[];

      const batchSize = 10;

      for (var i = 0; i < results.length; i += batchSize) {
        final batch = results.skip(i).take(batchSize);

        final futures = batch.map((pokemon) async {
          final url = pokemon['url'] as String;

          final detailResponse = await _dioClient.dio.get<Map<String, dynamic>>(url);

          return PokemonModel.fromJson(detailResponse.data!);
        });

        pokemons.addAll(await Future.wait(futures));
      }

      return pokemons;
    } on DioException catch (e) {
      throw Exception('Failed to fetch Pokémon list: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error while fetching Pokémon list: $e');
    }
  }
}

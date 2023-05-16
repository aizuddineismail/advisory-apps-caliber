import 'package:advisory_api/advisory_api.dart';
import 'package:dio/dio.dart';

class ItemRestApi extends ItemApi {
  ItemRestApi({
    required this.client,
    required this.baseUrl,
  });

  final Dio client;
  final String baseUrl;

  @override
  Future<List<Item>> getItems(
    String id,
    String token,
  ) async {
    try {
      final queries = {
        'id': id,
        'token': token,
      };
      final uri = Uri(
        scheme: 'http',
        host: baseUrl,
        path: '/index.php/listing',
        queryParameters: queries,
      );
      final response = await client.getUri<Map<String, dynamic>>(uri);
      final data = response.data!;
      final status = data['status'] as Map<String, dynamic>;

      if (status['code'] == 400) {
        throw CustomError(
          statusCode: status['code'] as int,
          message: status['message'] as String,
        );
      }

      final listing = data['listing'] as List;
      final items = <Item>[];

      for (final item in listing) {
        items.add(Item.fromJson(item as Map<String, dynamic>));
      }

      return items;
    } on DioError catch (e) {
      throw CustomError(
        statusCode: e.response?.statusCode ?? 0,
        message: e.response?.statusMessage ?? 'Error',
      );
    } catch (e) {
      rethrow;
    }
  }
}

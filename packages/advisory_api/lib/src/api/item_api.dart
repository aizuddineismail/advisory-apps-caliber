import 'package:advisory_api/src/models/models.dart';

abstract class ItemApi {
  Future<List<Item>> getItems(
    String id,
    String token,
  );
}

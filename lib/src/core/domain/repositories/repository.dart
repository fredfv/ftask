import '../entity_base.dart';

abstract class Repository<T extends EntityBase> {
  Future init(String path);

  Future<T?> get(String key);

  Future<dynamic> put(String? key, T value);

  Future delete(String key);

  Future<List<T>> getAll();
}

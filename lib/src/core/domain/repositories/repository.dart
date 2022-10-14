import '../entity_base.dart';

abstract class Repository<T extends EntityBase> {
  Future<T?> get(String key);

  Future<List<T>> getAll();

  Future<bool> put(String? key, T value);

  Future<bool> putMany(List<T> values);

  Future<bool> delete(String key);

  Future<bool> deleteMany(List<String> keys);
}

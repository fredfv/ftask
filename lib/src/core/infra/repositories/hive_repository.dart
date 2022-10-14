import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart' as db;
import 'package:task/src/core/domain/services/object_id_service.dart';

import '../../application/mapping/mapper.dart';
import '../../domain/entities/entity_base.dart';
import '../../domain/repositories/repository.dart';
import '../logger.dart';

class HiveReposiotry<T extends EntityBase> implements Repository<T> {
  final Mapper<T> mapper;
  final ObjectIdService objectId;

  HiveReposiotry({required this.mapper, required this.objectId});

  db.Box get box => db.Hive.box(T.toString());

  Future<bool> init(String path) async {
    try {
      fLog.w('[PATH $path]');
      await db.Hive.initFlutter(path);
      await db.Hive.openBox(T.toString());
      return true;
    } catch (e) {
      fLog.e(e);
      return false;
    }
  }

  @override
  Future<T?> get(String key) async {
    Map<String, dynamic>? map = box.get(key);
    T? value = mapper.fromJson(map);
    return value;
  }

  @override
  Future<List<T>> getAll() async {
    List list = box.values.toList();
    List<T> result = list.map((e) => mapper.fromJson(e)!).toList();
    return result;
  }

  //return id, true or false if was saved
  @override
  Future<bool> put(String? key, T value) async {
    try {
      if (key == null) {
        key ??= objectId.generate();
        value.setId(key);
      }

      Map<String, dynamic> map = mapper.toJson(value);
      await box.put(key, map);
      return true;
    } catch (e) {
      fLog.e(e);
      return false;
    }
  }

  @override
  Future<bool> putMany(List<T> values) async {
    try {
      Map<String, Map<String, dynamic>> map = {};
      for (T entity in values) {
        map.putIfAbsent(entity.id, () => entity.toJson());
      }
      await box.putAll(map);
      await box.flush();
      return true;
    } catch (e) {
      fLog.e(e);
      return false;
    }
  }

  @override
  Future<bool> delete(String key) async {
    try {
      box.delete(key);
      return true;
    } catch (e) {
      fLog.e(e);
      return false;
    }
  }

  @override
  Future<bool> deleteMany(List<String> keys) async {
    try {
      box.deleteAll(keys);
      return true;
    } catch (e) {
      fLog.e(e);
      return false;
    }
  }
}

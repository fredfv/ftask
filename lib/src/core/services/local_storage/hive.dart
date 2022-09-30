import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart' as db;

import '../../application/mapping/mapper.dart';
import '../../domain/entity_base.dart';
import '../../domain/repositories/repository.dart';
import '../../infra/logger.dart';

class Hive<T extends EntityBase> implements Repository<T> {
  final Mapper<T> mapper;

  Hive(this.mapper);

  db.Box get box => db.Hive.box(T.toString());

  @override
  Future init(String path) async {
    fLog.e('init s - ${DateTime.now()}');
    await db.Hive.initFlutter();
    fLog.e('init f - ${DateTime.now()}');
    await db.Hive.openBox(T.toString());
    fLog.e('open box - ${DateTime.now()}');
  }

  @override
  Future delete(String key) async {
    await init('path');
    box.delete(key);
  }

  @override
  Future<T?> get(String key) async {
    await init('path');
    Map<String, dynamic>? map = box.get(key);
    T? value = mapper.fromJson(map);
    return value;
  }

  @override
  Future<void> put(String key, T value) async {
    await init('path');
    Map<String, dynamic> map = mapper.toJson(value);
    await box.put(key, map);
  }

  @override
  Future<List<T>> getAll() async {
    await init('path');
    List list = box.values.toList();
    List<T> result = list.map((e) => mapper.fromJson(e)!).toList();
    return result;
  }
}

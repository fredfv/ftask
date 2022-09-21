import 'package:core/core.dart';
import 'package:core/domain/entity_base.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart' as db;

///REPOSITORY IMPL
class Hive<T extends EntityBase> implements Repository<T> {

  final Mapper<T> mapper;
  Hive(this.mapper);

  db.Box box() {
    var dbs = db.Hive.box(T.toString());
    return dbs;
  }

  @override
  Future delete(String key) async {
    box().delete(key);
  }

  @override
  Future<T?> get(String key) async {
    Map<String, dynamic>? map = box().get(key);
    T? value = mapper.fromMap(map);
    return value;
  }

  @override
  Future<void> put(String key, T value) async {
    Map<String, dynamic> map = mapper.toMap(value);
    await box().put(key, map);
  }

  @override
  Future init(String path) async {
    await db.Hive.initFlutter(path);
    await db.Hive.openBox(T.toString());
  }

  @override
  Future<List<T>> getAll() async{
    List list = box().values.toList();
    List<T> result = list.map((e) => mapper.fromMap(e)!).toList();
    return result;
  }
}

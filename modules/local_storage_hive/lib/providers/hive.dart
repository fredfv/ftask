import 'package:core/domain/entity_base.dart';
import 'package:core/domain/map/mapper.dart';
import 'package:core/domain/repositories/repository.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart' as db;

///REPOSITORY IMPL
class Hive<T extends EntityBase> implements Repository<T> {

  final Mapper<T> mapper;
  Hive(this.mapper);

  db.Box get box =>  db.Hive.box(T.toString());

  @override
  Future init(String path) async {
    print(DateTime.now());
    await db.Hive.initFlutter();
    print(DateTime.now());
    await db.Hive.openBox(T.toString());
    print(DateTime.now());
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
    T? value = mapper.fromMap(map);
    return value;
  }

  @override
  Future<void> put(String key, T value) async {
    await init('path');
    Map<String, dynamic> map = mapper.toMap(value);
    await box.put(key, map);
  }

  @override
  Future<List<T>> getAll() async{
    await init('path');
    List list = box.values.toList();
    List<T> result = list.map((e) => mapper.fromMap(e)!).toList();
    return result;
  }
}

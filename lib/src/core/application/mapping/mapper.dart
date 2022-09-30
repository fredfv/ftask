import '../../domain/entity_base.dart';

abstract class Mapper<T extends EntityBase> {
  T? fromJson(Map<String, dynamic>? map);

  Map<String, dynamic> toJson(T value);
}

import '../../domain/entity_base.dart';

abstract class Mapper<T extends EntityBase> {
  T? fromJson(dynamic map);

  Map<String, dynamic> toJson(T value);
}

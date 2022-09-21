import 'package:core/domain/entity_base.dart';

abstract class Mapper<T extends EntityBase>{

  T? fromMap(Map<String, dynamic>? map);
  Map<String, dynamic> toMap(T value);

}
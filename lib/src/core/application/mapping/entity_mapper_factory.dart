import 'package:task/src/core/domain/entities/task_entity.dart';

import '../../domain/entities/entity_base.dart';
import '../../domain/entities/user_entity.dart';
import 'mapper.dart';
import 'task_mapper.dart';
import 'user_mapper.dart';

class EntityMapperFactory {
  Mapper<T> get<T extends EntityBase>() {
    if (T == TaskEntity) return TaskMapper() as Mapper<T>;
    if (T == UserEntity) return UserMapper() as Mapper<T>;
    throw Exception('Entity "${T.toString()}" not found');
  }
}

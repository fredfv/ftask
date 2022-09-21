import 'package:core/domain/task_entity.dart';

import 'repository.dart';

abstract class TaskRepository extends Repository<TaskEntity> {
  Future<List<TaskEntity>> doisPrimeiros();
}

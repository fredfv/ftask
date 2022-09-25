import 'package:core/domain/repositories/task_repository.dart';
import 'package:core/domain/task_entity.dart';
import 'package:local_storage_hive/providers/hive.dart';

class TaskRepositoryImpl extends Hive<TaskEntity> implements TaskRepository {
  TaskRepositoryImpl() : super(TaskMapper());

  @override
  Future<List<TaskEntity>> doisPrimeiros() {
    // TODO: implement doisPrimeiros
    throw UnimplementedError();
  }
}

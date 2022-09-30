import '../../../core/application/mapping/task_mapper.dart';
import '../../../core/domain/repositories/task_repository.dart';
import '../../../core/domain/task_entity.dart';
import '../../local_storage/hive.dart';

class TaskRepositoryImpl extends Hive<TaskEntity> implements TaskRepository {
  TaskRepositoryImpl() : super(TaskMapper());

  @override
  Future<List<TaskEntity>> doisPrimeiros() {
    // TODO: implement doisPrimeiros
    throw UnimplementedError();
  }
}

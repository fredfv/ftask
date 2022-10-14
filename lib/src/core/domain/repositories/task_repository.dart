import '../task_entity.dart';
import 'repository.dart';

abstract class TaskRepository extends Repository<TaskEntity> {
  Future<List<TaskEntity>> getTasks();

  Future putTask(TaskEntity task);
}

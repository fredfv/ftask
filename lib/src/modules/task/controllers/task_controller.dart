import 'package:core/domain/task_entity.dart';
import 'package:task/src/modules/task/repositories/task_repository_impl.dart';

class TaskController {
  final TaskRepositoryImpl _taskRepository;

  TaskController(this._taskRepository);

  void set() async{
    //await _taskRepository.init('path');
    await _taskRepository.put(
        '2',
        TaskEntity(
            description: 'description',
            id: '3',
            created: DateTime.now().toUtc()));
  }

  void get() async{
    await _taskRepository.init('path');
    print(await _taskRepository.get('3'));
    print(await _taskRepository.get('2'));
  }
}
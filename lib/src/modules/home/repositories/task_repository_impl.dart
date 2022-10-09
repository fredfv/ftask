import 'package:task/src/core/domain/repositories/task_repository.dart';
import 'package:task/src/core/domain/task_entity.dart';
import 'package:task/src/core/services/http_service.dart';

import '../../../core/application/mapping/task_mapper.dart';
import '../../../core/services/local_storage/hive.dart';
import '../../../core/services/object_id_service.dart';

class TaskRepositoryImpl extends Hive<TaskEntity> implements TaskRepository {
  final HttpService httpService;
  TaskRepositoryImpl({
    required this.httpService,
    required ObjectIdService objectIdService,
  }) : super(
          mapper: TaskMapper(),
          objectId: objectIdService,
        );
}

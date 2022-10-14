import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/domain/repositories/repository.dart';
import '../../../core/domain/repositories/repository_factory.dart';
import '../../../core/domain/task_entity.dart';
import '../../../core/domain/use_cases/update_tasks_from_cloud_use_case.dart';
import '../../../core/domain/user_entity.dart';
import '../../../core/infra/http_request_methods.dart';
import '../../../core/services/http_service.dart';

class UpdateTasksFromCloudUseCaseImpl implements UpdateTasksFromCloudUseCase {
  final HttpService httpService;
  final RepositoryFactory repositoryFactory;

  UpdateTasksFromCloudUseCaseImpl({required this.httpService, required this.repositoryFactory});

  @override
  Future<bool> call() async {
    var loggedUser = Modular.get<UserEntity>();

    var list = await httpService.request(
        baseUrl: 'http://192.168.15.3:5001',
        endPoint: '/task/getall',
        method: HttpRequestMethods.get,
        token: loggedUser.token,
        receiveTimeout: 5000,
        connectTimeout: 10000);

    Repository<TaskEntity> repository = await repositoryFactory.get<TaskEntity>();
    List<TaskEntity> listTask = list.map<TaskEntity>((e) => TaskEntity.fromApi(e)).toList();
    await repository.putMany(listTask);
    return true;
  }
}

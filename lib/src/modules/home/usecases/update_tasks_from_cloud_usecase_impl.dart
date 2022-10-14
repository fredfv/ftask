import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/domain/entities/task_entity.dart';
import '../../../core/domain/entities/user_entity.dart';
import '../../../core/domain/repositories/repository.dart';
import '../../../core/domain/repositories/repository_factory.dart';
import '../../../core/domain/services/http_service.dart';
import '../../../core/domain/usecases/update_tasks_from_cloud_usecase.dart';
import '../../../core/infra/http_request_methods.dart';

class UpdateTasksFromCloudUsecaseImpl implements UpdateTasksFromCloudUsecase {
  final HttpService httpService;
  final RepositoryFactory repositoryFactory;

  UpdateTasksFromCloudUsecaseImpl({required this.httpService, required this.repositoryFactory});

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

import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/domain/entities/task_entity.dart';
import '../../../core/domain/entities/user_entity.dart';
import '../../../core/domain/repositories/i_repository.dart';
import '../../../core/domain/repositories/i_repository_factory.dart';
import '../../../core/domain/services/i_http_service.dart';
import '../../../core/domain/usecases/i_update_tasks_from_cloud_usecase.dart';
import '../../../core/infra/application/http_request_methods.dart';

class UpdateTasksFromCloudUsecase implements IUpdateTasksFromCloudUsecase {
  final IHttpService httpService;
  final IRepositoryFactory repositoryFactory;

  UpdateTasksFromCloudUsecase(
      {required this.httpService, required this.repositoryFactory});

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

    IRepository<TaskEntity> repository =
        await repositoryFactory.get<TaskEntity>();
    List<TaskEntity> listTask =
        list.map<TaskEntity>((e) => TaskEntity.fromCloud(e)).toList();
    await repository.putMany(listTask);
    return true;
  }
}

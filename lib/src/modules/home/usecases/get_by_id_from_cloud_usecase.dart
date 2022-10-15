import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/domain/entities/task_entity.dart';
import '../../../core/domain/entities/user_entity.dart';
import '../../../core/domain/repositories/i_repository.dart';
import '../../../core/domain/repositories/i_repository_factory.dart';
import '../../../core/domain/services/i_http_service.dart';
import '../../../core/domain/usecases/i_get_by_id_from_cloud_usecase.dart';
import '../../../core/infra/application/http_request_methods.dart';

class GetByIdFromCloudUsecase implements IGetByIdFromCloudUsecase {
  final IHttpService httpService;
  final IRepositoryFactory repositoryFactory;

  GetByIdFromCloudUsecase(
      {required this.httpService, required this.repositoryFactory});

  @override
  Future<bool> call(String id) async {
    var loggedUser = Modular.get<UserEntity>();

    var entity = await httpService.request(
        baseUrl: 'http://192.168.15.3:5001',
        endPoint: '/task/get',
        method: HttpRequestMethods.get,
        params: {'id': id},
        token: loggedUser.token,
        receiveTimeout: 5000,
        connectTimeout: 10000);

    IRepository<TaskEntity> repository =
        await repositoryFactory.get<TaskEntity>();
    TaskEntity task = TaskEntity.fromCloud(entity);
    await repository.put(task.id, task);
    return true;
  }
}

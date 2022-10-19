import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/core/infra/application/api_path.dart';

import '../../../core/domain/entities/task_entity.dart';
import '../../../core/domain/entities/user_entity.dart';
import '../../../core/domain/repositories/i_repository.dart';
import '../../../core/domain/repositories/i_repository_factory.dart';
import '../../../core/domain/services/i_http_service.dart';
import '../../../core/domain/usecases/i_download_tasks_from_cloud_usecase.dart';
import '../../../core/infra/application/api_endpoints.dart';
import '../../../core/infra/application/http_request_methods.dart';
import '../../../core/infra/application/http_timeout_configurations.dart';

class DownloadTasksFromCloudUsecase implements IDownloadTasksFromCloudUsecase {
  final IHttpService httpService;
  final IRepositoryFactory repositoryFactory;
  final UserEntity user;

  DownloadTasksFromCloudUsecase({required this.httpService, required this.repositoryFactory, required this.user});

  @override
  Future<bool> call() async {
    var list = await httpService.request(
        baseUrl: ApiPath.baseUrl,
        endPoint: ApiEndpoints.getAll,
        method: HttpRequestMethods.get,
        token: user.token,
        receiveTimeout: HttpTimeoutConfigurations.receiveTimeoutUsecases,
        connectTimeout: HttpTimeoutConfigurations.connectTimeoutUsecases);

    if (list is Exception) {
      return false;
    }

    IRepository<TaskEntity> repository = await repositoryFactory.get<TaskEntity>();
    List<TaskEntity> listTask = list.map<TaskEntity>((e) => TaskEntity.fromCloud(e)).toList();
    await repository.putMany(listTask);
    return true;
  }
}

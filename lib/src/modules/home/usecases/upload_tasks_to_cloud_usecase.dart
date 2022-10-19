import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/domain/entities/task_entity.dart';
import '../../../core/domain/entities/user_entity.dart';
import '../../../core/domain/repositories/i_repository.dart';
import '../../../core/domain/repositories/i_repository_factory.dart';
import '../../../core/domain/services/i_http_service.dart';
import '../../../core/domain/usecases/i_upload_tasks_to_cloud_usecase.dart';
import '../../../core/infra/application/api_path.dart';
import '../../../core/infra/application/api_endpoints.dart';
import '../../../core/infra/application/http_request_methods.dart';
import '../../../core/infra/application/http_timeout_configurations.dart';

class UploadTasksToCloudUsecase implements IUploadTasksToCloudUsecase {
  final IHttpService httpService;
  final IRepositoryFactory repositoryFactory;
  final UserEntity user;

  UploadTasksToCloudUsecase({required this.repositoryFactory, required this.httpService, required this.user});

  @override
  Future<bool> call() async {
    IRepository<TaskEntity> repository = await repositoryFactory.get<TaskEntity>();
    List<TaskEntity> listTask = await repository.getAll();
    var listToCloud = listTask.map<Map<String, dynamic>>((e) => e.toCloud()).toList();
    var payload = {
      'userId': user.id,
      'values': listToCloud,
    };

    httpService.request(
        baseUrl: ApiPath.baseUrl,
        endPoint: ApiEndpoints.upsertAll,
        method: HttpRequestMethods.put,
        token: user.token,
        params: payload,
        receiveTimeout: HttpTimeoutConfigurations.receiveTimeoutUsecases,
        connectTimeout: HttpTimeoutConfigurations.connectTimeoutUsecases);

    return true;
  }
}

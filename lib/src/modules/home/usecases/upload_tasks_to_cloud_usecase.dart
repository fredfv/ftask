import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/domain/entities/task_entity.dart';
import '../../../core/domain/entities/user_entity.dart';
import '../../../core/domain/repositories/i_repository.dart';
import '../../../core/domain/repositories/i_repository_factory.dart';
import '../../../core/domain/services/i_http_service.dart';
import '../../../core/domain/usecases/i_upload_tasks_to_cloud_usecase.dart';
import '../../../core/infra/application/http_request_methods.dart';

class UploadTasksToCloudUsecase implements IUploadTasksToCloudUsecase {
  final IHttpService httpService;
  final IRepositoryFactory repositoryFactory;

  UploadTasksToCloudUsecase({required this.repositoryFactory, required this.httpService});

  @override
  Future<bool> call() async {
    var loggedUser = Modular.get<UserEntity>();

    IRepository<TaskEntity> repository = await repositoryFactory.get<TaskEntity>();
    List<TaskEntity> listTask = await repository.getAll();
    var listToCloud = listTask.map<Map<String, dynamic>>((e) => e.toCloud()).toList();

    httpService.request(
        baseUrl: 'http://192.168.15.3:5001',
        endPoint: '/task/uploadall',
        method: HttpRequestMethods.put,
        token: loggedUser.token,
        params: listToCloud,
        receiveTimeout: 5000,
        connectTimeout: 10000);

    return true;
  }
}

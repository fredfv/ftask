import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/core/domain/entities/task_entity.dart';
import 'package:task/src/core/domain/services/i_http_service.dart';
import 'package:task/src/core/domain/usecases/i_set_on_board_status_usecase.dart';

import '../../../core/domain/entities/user_entity.dart';
import '../../../core/domain/repositories/i_repository_factory.dart';
import '../../../core/infra/application/api_path.dart';
import '../../../core/infra/application/api_endpoints.dart';
import '../../../core/infra/application/http_request_methods.dart';
import '../../../core/infra/application/http_timeout_configurations.dart';

class SetOnBoardStatusUseCase implements ISetOnBoardStatusUsecase {
  final IHttpService httpService;
  final IRepositoryFactory repositoryFactory;
  final UserEntity user;

  SetOnBoardStatusUseCase({required this.repositoryFactory, required this.httpService, required this.user});

  @override
  Future<bool> call(String id, bool onBoard) async {
    var repository = await repositoryFactory.get<TaskEntity>();
    var entity = await repository.get(id);
    if (entity != null) {
      int date = DateTime.now().millisecondsSinceEpoch;
      entity.setPersisted(date);
      entity.setUpdated(date);
      entity.setPending(true);
      await repository.put(id, entity);

      entity.setOnBoard(onBoard);
      var payload = {
        'userId': user.id,
        'value': entity.toCloud(),
      };

      httpService.request(
          baseUrl: ApiPath.baseUrl,
          endPoint: ApiEndpoints.upsertOne,
          method: HttpRequestMethods.put,
          params: payload,
          token: user.token,
          receiveTimeout: HttpTimeoutConfigurations.receiveTimeoutUsecases,
          connectTimeout: HttpTimeoutConfigurations.connectTimeoutUsecases);
    }
    return true;
  }
}

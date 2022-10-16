import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/core/domain/entities/task_entity.dart';
import 'package:task/src/core/domain/services/i_http_service.dart';
import 'package:task/src/core/domain/usecases/i_set_on_board_status_usecase.dart';

import '../../../core/domain/entities/user_entity.dart';
import '../../../core/domain/repositories/i_repository_factory.dart';
import '../../../core/infra/application/http_request_methods.dart';

class SetOnBoardStatusUseCase implements ISetOnBoardStatusUsecase {
  final IHttpService httpService;
  final IRepositoryFactory repositoryFactory;

  SetOnBoardStatusUseCase({required this.repositoryFactory, required this.httpService});

  @override
  Future<bool> call(String id, bool onBoard) async {
    var loggedUser = Modular.get<UserEntity>();

    var repository = await repositoryFactory.get<TaskEntity>();
    var entity = await repository.get(id);
    if (entity != null) {
      int date = DateTime.now().millisecondsSinceEpoch;
      entity.setPersisted(date);
      entity.setUpdated(date);
      entity.setOnBoard(onBoard);
      await repository.put(id, entity);

      await httpService.request(
          baseUrl: 'http://192.168.15.3:5001',
          endPoint: '/task/rule/upsertone',
          method: HttpRequestMethods.put,
          params: entity.toCloud(),
          token: loggedUser.token,
          receiveTimeout: 5000,
          connectTimeout: 10000);
    }
    return true;
  }
}

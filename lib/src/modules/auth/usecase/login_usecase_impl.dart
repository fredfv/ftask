import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/domain/entities/user_entity.dart';
import '../../../core/domain/repositories/i_repository.dart';
import '../../../core/domain/repositories/i_repository_factory.dart';
import '../../../core/domain/services/i_http_service.dart';
import '../../../core/domain/usecases/i_login_usecase.dart';
import '../../../core/infra/application/http_request_methods.dart';
import '../../../core/infra/application/logger.dart';
import '../../../core/infra/application/login_request.dart';

class LoginUseCaseImpl implements ILoginUsecase {
  final IHttpService httpService;
  final IRepositoryFactory repositoryFactory;

  LoginUseCaseImpl(
      {required this.httpService, required this.repositoryFactory});

  @override
  Future<UserEntity?> call(LoginRequest loginRequest) async {
    try {
      var authUser = await httpService.request(
          baseUrl: 'http://192.168.15.3:5001',
          endPoint: '/Person/auth',
          method: HttpRequestMethods.post,
          params: loginRequest.toJson(),
          receiveTimeout: 5000,
          connectTimeout: 10000);

      IRepository<UserEntity> repository =
          await repositoryFactory.get<UserEntity>();
      UserEntity userAuthModel = UserEntity.fromAuth(authUser);
      await repository.put(userAuthModel.id, userAuthModel);
      Modular.get<UserEntity>().setAuthUser(userAuthModel);
      return userAuthModel;
    } catch (e) {
      fLog.e(e);
      return null;
    }
  }
}

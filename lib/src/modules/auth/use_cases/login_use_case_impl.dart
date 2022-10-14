import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/application/login_request.dart';
import '../../../core/domain/repositories/repository.dart';
import '../../../core/domain/repositories/repository_factory.dart';
import '../../../core/domain/use_cases/login_use_case.dart';
import '../../../core/domain/user_entity.dart';
import '../../../core/infra/http_request_methods.dart';
import '../../../core/infra/logger.dart';
import '../../../core/services/http_service.dart';

class LoginUseCaseImpl implements LoginUseCase {
  final HttpService httpService;
  final RepositoryFactory repositoryFactory;

  LoginUseCaseImpl({required this.httpService, required this.repositoryFactory});

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

      Repository<UserEntity> repository = await repositoryFactory.get<UserEntity>();
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

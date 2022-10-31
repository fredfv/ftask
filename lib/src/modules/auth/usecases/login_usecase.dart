import 'package:dartz/dartz.dart';
import 'package:task/src/core/domain/repositories/i_loggin_repository.dart';
import 'package:task/src/core/domain/usecase/i_usecase.dart';
import 'package:task/src/core/presenter/theme/lexicon.dart';

import '../../../core/domain/entities/user_entity.dart';
import '../../../core/domain/repositories/i_repository.dart';
import '../../../core/domain/repositories/i_repository_factory.dart';
import '../../../core/domain/services/i_http_service.dart';
import '../../../core/domain/usecase/errors/failures.dart';
import '../../../core/infra/application/api_endpoints.dart';
import '../../../core/infra/application/app_settings.dart';
import '../../../core/infra/application/http_request_methods.dart';
import '../../../core/infra/application/http_timeout_configurations.dart';
import '../../../core/infra/application/logger.dart';
import '../../../core/infra/application/login_request.dart';

class LoginUsecase implements IUsecase<UserEntity, LoginRequest> {
  final IHttpService httpService;
  final ILoginRepository loginRepository;
  final UserEntity user;

  LoginUsecase({required this.httpService, required this.loginRepository, required this.user});

  @override
  Future<Either<Failure, UserEntity>> call(LoginRequest loginRequest) async {
    try {
      var authUser = await loginRepository.loginLocal(loginRequest.login, loginRequest.secret);
      authUser.fold((l)async{
        authUser = await loginRepository.loginCloud(loginRequest.login, loginRequest.secret);
        authUser.fold((l)async{
          return Left(ServerFailure());
        }, (r)async{
          await loginRepository.persistUser(r);
          return Right(r);
        });
        
      }, (r) => null);


      if (authUser.isRight()) {

      } else {
        authUser = await loginRepository.loginCloud(loginRequest.login, loginRequest.secret);
        if (authUser.isRight()) {
          await loginRepository.persistUser(authUser.getOrElse(() => user));
          return Right(authUser);
        }else{
          return Left(ServerFailure());
        }
      }

      IRepository<UserEntity> repository = await repositoryFactory.get<UserEntity>();
      UserEntity userAuthModel = UserEntity.fromAuth(authUser);
      await repository.put(userAuthModel.id, userAuthModel);
      user.setAuthUser(userAuthModel);
      return userAuthModel;
    } catch (e) {
      fLog.e(e);
      return null;
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:task/src/core/domain/repositories/i_loggin_repository.dart';
import 'package:task/src/core/domain/repositories/i_repository_factory.dart';
import 'package:task/src/core/domain/services/i_http_service.dart';
import 'package:task/src/core/infra/application/http_request_methods.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/i_repository.dart';
import '../../domain/usecase/errors/failures.dart';

class LoginRepository implements ILoginRepository {
  final IRepositoryFactory repositoryFactory;
  final IHttpService httpService;

  LoginRepository({required this.repositoryFactory, required this.httpService});

  @override
  Future<Either<Failure, UserEntity>> loginCloud(String email, String password) async {
    try {
      var authUser = await httpService.request(
          baseUrl: 'https://reqres.in',
          endPoint: '/api/login',
          method: HttpRequestMethods.get,
          params: {'email': email, 'password': password},
          receiveTimeout: 5000,
          connectTimeout: 5000);

      UserEntity userAuthModel = UserEntity.fromAuth(authUser);
      return Right(userAuthModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginLocal(String email, String password) async {
    try {
      IRepository<UserEntity> userRepo = await repositoryFactory.get<UserEntity>();
      var users = await userRepo.getAll();
      return Right(users.last);
    } catch (e) {
      return Left(LocalDataBaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> persistUser(UserEntity user) async {
    try {
      IRepository<UserEntity> repository = await repositoryFactory.get<UserEntity>();
      await repository.put(user.id, user);
      return const Right(true);
    } catch (e) {
      return Left(LocalDataBaseFailure());
    }
  }
}

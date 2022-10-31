import 'package:dartz/dartz.dart';
import 'package:task/src/core/domain/entities/user_entity.dart';

import '../usecase/errors/failures.dart';

abstract class ILoginRepository {
  Future<Either<Failure, UserEntity>> loginCloud(String email, String password);
  Future<Either<Failure, UserEntity>> loginLocal(String email, String password);
  Future<Either<Failure, bool>> persistUser(UserEntity user);
}

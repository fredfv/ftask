import '../../application/login_request.dart';
import '../entities/user_entity.dart';

abstract class LoginUseCase {
  Future<UserEntity?> call(LoginRequest loginRequest);
}

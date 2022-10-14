import '../../application/login_request.dart';
import '../user_entity.dart';

abstract class LoginUseCase {
  Future<UserEntity?> call(LoginRequest loginRequest);
}

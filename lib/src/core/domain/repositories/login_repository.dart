import '../../application/create_account_request.dart';
import '../../application/login_request.dart';
import '../user_entity.dart';
import 'repository.dart';

abstract class LoginRepository extends Repository<UserEntity> {
  Future login(LoginRequest loginRequest);

  Future createAccount(CreateAccountRequest newAccount);

  Future persistAuthLogin(Map<String, dynamic> response);

  //IF U SEND AN ID IT WILL BE BY IT, OTHERWISE IT WILL PICK THE LAST USER TO AUTH
  Future<bool> isAuthenticated(String? idLoggeduser);

  Future<UserEntity> getLoggedUser();
}

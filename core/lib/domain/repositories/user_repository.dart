import '../application/create_account_request.dart';
import '../user_entity.dart';
import 'repository.dart';

abstract class UserRepository extends Repository<UserEntity>{
  Future login(String login, String secret);
  Future createAccount(CreateAccountRequest newAccount);
}

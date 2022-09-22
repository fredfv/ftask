import '../user_entity.dart';
import 'repository.dart';

abstract class UserRepository extends Repository<UserEntity>{
  Future login(String login, String secret);
}

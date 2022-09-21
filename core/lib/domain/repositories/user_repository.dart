import 'package:core/core.dart';
import 'package:core/domain/user_entity.dart';

abstract class UserRepository extends Repository<UserEntity>{
  Future<bool> login(String login, String secret);
}

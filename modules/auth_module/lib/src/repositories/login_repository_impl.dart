import 'package:core/domain/repositories/user_repository.dart';
import 'package:core/domain/user_entity.dart';
import 'package:local_storage_hive/provider/hive.dart';

class LoginRepositoryImpl extends Hive<UserEntity> implements UserRepository {
  LoginRepositoryImpl() : super(TaskMapper());

  @override
  Future<bool> login(String email, String secret) async {
    await init('path');

    await put(
        'id',
        UserEntity(
            login: 'login',
            secret: 'secret',
            name: 'name',
            id: 'id',
            created: DateTime.now().toUtc()));

    print(await get('id'));

    return true;
  }
}

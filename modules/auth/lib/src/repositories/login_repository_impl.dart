import 'package:core/domain/application/http_request_methods.dart';
import 'package:core/domain/repositories/user_repository.dart';
import 'package:core/domain/services/http_service.dart';
import 'package:core/domain/user_entity.dart';
import 'package:local_storage_hive/providers/hive.dart';

class LoginRepositoryImpl extends Hive<UserEntity> implements UserRepository {
  final HttpService httpService;

  LoginRepositoryImpl(this.httpService) : super(TaskMapper());

  @override
  Future login(String email, String secret) async {
    await init('path');
    try{
      var response = await httpService.request(
          baseUrl: 'http://192.168.15.3:5001',
          endPoint: '/Person/auth',
          method: HttpRequestMethods.post,
          params: {'password': secret, 'username': email},
          receiveTimeout: 50000,
          connectTimeout: 100000);
      print(response);
    }catch(e){
      throw Exception(e);
    }
  }
}

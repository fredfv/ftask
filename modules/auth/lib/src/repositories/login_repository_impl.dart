import 'package:core/domain/application/create_account_request.dart';
import 'package:core/domain/application/login_request.dart';
import 'package:core/domain/http_request_methods.dart';
import 'package:core/domain/repositories/login_repository.dart';
import 'package:core/domain/services/http_service.dart';
import 'package:core/domain/user_entity.dart';
import 'package:local_storage_hive/providers/hive.dart';

class LoginRepositoryImpl extends Hive<UserEntity> implements LoginRepository {
  final HttpService httpService;

  LoginRepositoryImpl(this.httpService) : super(UserMapper());

  @override
  Future login(LoginRequest loginRequest) async {
    return httpService.request(
        baseUrl: 'http://192.168.15.3:5001',
        endPoint: '/Person/auth',
        method: HttpRequestMethods.post,
        params: loginRequest.toJson(),
        receiveTimeout: 5000,
        connectTimeout: 10000);
  }

  @override
  Future createAccount(CreateAccountRequest newAccount) async {
    return httpService.request(
        baseUrl: 'http://192.168.15.3:5001',
        endPoint: '/Person/createaccount',
        method: HttpRequestMethods.post,
        params: newAccount.toJson(),
        receiveTimeout: 5000,
        connectTimeout: 10000);
  }

  @override
  Future persistAuthLogin(Map<String, dynamic> response) async {
    UserEntity user = UserEntity.fromAuth(response);
    await put(user.id, user);
  }
}

import 'package:core/domain/application/create_account_request.dart';
import 'package:core/domain/application/custom_exception.dart';
import 'package:core/domain/application/http_request_methods.dart';
import 'package:core/domain/application/login_request.dart';
import 'package:core/domain/repositories/login_repository.dart';
import 'package:core/domain/services/http_service.dart';
import 'package:core/domain/user_entity.dart';
import 'package:core/infra/logger.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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
    user.created = DateTime.now().toUtc();
    await put(user.id, user);
  }

  @override
  Future<bool> isAuthenticated(String? idLoggedUser) async{
    if(idLoggedUser==null){
      var lastUser = await getLoggedUser();
      idLoggedUser = lastUser.id;
    }
    var userToVerify = await get(idLoggedUser);
    if(userToVerify == null ) throw CustomException('user not found');
    return JwtDecoder.isExpired(userToVerify.token);
  }

  @override
  Future<UserEntity> getLoggedUser() async{
      var allUsers = box.values.toList();
      allUsers.sort((a, b) => a['created'].compareTo(b['created']));
      fLog.wtf(allUsers.last.toString());
      fLog.wtf(allUsers.first.toString());
      return UserEntity.fromJson(allUsers.last);
  }
}

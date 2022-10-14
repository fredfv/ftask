import '../domain/services/validators/login_vo.dart';
import '../domain/services/validators/secret_vo.dart';

class LoginRequest {
  LoginVO _login;
  SecretVO _secret;

  LoginVO get login => _login;

  void setLogin(String? value) => _login = LoginVO(value ?? '');

  SecretVO get secret => _secret;

  void setSecret(String? value) => _secret = SecretVO(value ?? '');

  LoginRequest({
    required String login,
    required String secret,
  })  : _login = LoginVO(login),
        _secret = SecretVO(secret);

  factory LoginRequest.empty() {
    return LoginRequest(
      login: '',
      secret: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': login.toString(),
      'password': secret.toString(),
    };
  }

  static LoginRequest fromJson(dynamic data) {
    return LoginRequest(
      login: data['login'],
      secret: data['secret'],
    );
  }
}

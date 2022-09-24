import 'package:core/domain/value_objects/login_vo.dart';
import 'package:core/domain/value_objects/name_vo.dart';
import 'package:core/domain/value_objects/secret_vo.dart';

class CreateAccountRequest {
  NameVO _name;
  LoginVO _login;
  SecretVO _secret;
  SecretVO _secretConfirm;

  NameVO get name => _name;

  void setName(String? value) => _name = NameVO(value ?? '');

  LoginVO get login => _login;

  void setLogin(String? value) => _login = LoginVO(value ?? '');

  SecretVO get secret => _secret;

  void setSecret(String? value) => _secret = SecretVO(value ?? '');

  SecretVO get secretConfirm => _secretConfirm;

  void setSecretConfirm(String? value) =>
      _secretConfirm = SecretVO(value ?? '');

  CreateAccountRequest({
    required String name,
    required String login,
    required String secret,
    required String secretConfirm,
  })  : _name = NameVO(name),
        _login = LoginVO(login),
        _secret = SecretVO(secret),
        _secretConfirm = SecretVO(secretConfirm);

  factory CreateAccountRequest.empty() {
    return CreateAccountRequest(
      name: '',
      login: '',
      secret: '',
      secretConfirm: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': login.toString(),
      'password': secret.toString(),
      'name': name.toString()
    };
  }

  static CreateAccountRequest fromJson(dynamic data) {
    return CreateAccountRequest(
      name: data['name'],
      login: data['login'],
      secret: data['secret'],
      secretConfirm: data['secretConfirm'],
    );
  }
}

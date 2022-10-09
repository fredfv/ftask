import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task/src/core/application/create_account_request.dart';
import 'package:task/src/core/application/custom_exception.dart';
import 'package:task/src/core/domain/repositories/login_repository.dart';
import 'package:task/src/core/infra/http_request_methods.dart';
import 'package:task/src/core/services/http_service.dart';

import '../../../core/services/http/http_service_dio_impl_test.dart';

class LoginRepositoryMock extends Mock implements LoginRepository {
  final HttpService httpService;

  LoginRepositoryMock(this.httpService);

  /// Mock the request calling it passing a login as param with value of 'test
  /// and return a response with value of 'ok'
  /// If not pass a login param, return a exception
  @override
  Future createAccount(CreateAccountRequest newAccount) async {
    return httpService.request(
      baseUrl: 'https://www.google.com',
      endPoint: 'test',
      method: HttpRequestMethods.get,
      params: newAccount.login.toString() == 'test' ? newAccount.toJson() : null,
    );
  }
}

void main() {
  final repository = LoginRepositoryMock(HttpServiceMock());

  test('should be a instance of LoginRepository', () {
    expect(repository, isA<LoginRepository>());
  });

  test('should return a response', () async {
    final result = await repository
        .createAccount(CreateAccountRequest(login: 'test', secret: 'test', name: 'test', secretConfirm: 'test'));
    expect(result, {'response': 'ok'}, reason: 'Pass a param and return a response');
  });

  test('should return a exception', () async {
    final result = await repository
        .createAccount(CreateAccountRequest(login: 'test2', secret: 'test', name: 'test', secretConfirm: 'test'));
    expect(result, isA<CustomException>(),
        reason: 'Forcing not pass a param and return a exception, when login is not equal to test');
  });
}

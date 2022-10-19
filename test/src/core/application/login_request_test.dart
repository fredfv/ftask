import 'package:flutter_test/flutter_test.dart';
import 'package:task/src/core/application/login_request.dart';

void main() {
  test('should create an a empty class', () {
    final loginRequest = LoginRequest.empty();
    expect(loginRequest.login.toString(), '');
    expect(loginRequest.secret.toString(), '');
  });

  test('should create an a new empty class with values', () {
    LoginRequest newEmptyClass = LoginRequest.empty();
    newEmptyClass.setLogin('login');
    newEmptyClass.setSecret('secret');
    expect(newEmptyClass.login.toString(), 'login');
    expect(newEmptyClass.secret.toString(), 'secret');
  });

  LoginRequest loginRequest = LoginRequest.empty();

  test('should implements a toString', () {
    expect(loginRequest.toString(), isA<String>());
  });

  test('should be a instance of LoginRequest', () {
    expect(loginRequest, isA<LoginRequest>());
  });

  test('should return a error showing what is wrong in the field when not pass a value', () {
    expect(loginRequest.login.validate(), 'fill the field to submit');
  });

  test('should return null when pass a value with one word', () {
    loginRequest.setLogin('test');
    expect(loginRequest.login.validate(), null);
  });

  test('should return a error showing what is wrong in the field when not pass a value', () {
    expect(loginRequest.secret.validate(), 'fill the field to submit');
  });

  test('should return null when pass a value with one word', () {
    loginRequest.setSecret('test');
    expect(loginRequest.secret.validate(), null);
  });

  test('implements toJson', () {
    final loginRequest = LoginRequest.empty();
    expect(loginRequest.toJson(), isA<Map<String, dynamic>>());
  });

  test('should return a json with the values of the fields', () {
    loginRequest.setLogin('login');
    loginRequest.setSecret('secret');
    expect(loginRequest.toJson(), {'username': 'login', 'password': 'secret'});
  });

  test('implements fromJson', () {
    final loginRequest = LoginRequest.fromJson({'login': 'login', 'secret': 'secret'});
    expect(loginRequest, isA<LoginRequest>());
  });

  test('should return a class with the values of the json', () {
    final loginRequest = LoginRequest.fromJson({'login': 'login', 'secret': 'secret'});
    expect(loginRequest.login.toString(), 'login');
    expect(loginRequest.secret.toString(), 'secret');
  });
}

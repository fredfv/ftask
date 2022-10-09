import 'package:flutter_test/flutter_test.dart';
import 'package:task/src/core/application/create_account_request.dart';

void main() {
  test('should create an a empty class', () {
    final createAccountRequest = CreateAccountRequest.empty();
    expect(createAccountRequest.login.toString(), '');
    expect(createAccountRequest.secret.toString(), '');
    expect(createAccountRequest.secretConfirm.toString(), '');
  });

  test('should create an a new empty class with values', () {
    CreateAccountRequest newEmptyClass = CreateAccountRequest.empty();
    newEmptyClass.setName('name');
    newEmptyClass.setLogin('login');
    newEmptyClass.setSecret('secret');
    newEmptyClass.setSecretConfirm('secretConfirm');

    expect(newEmptyClass.name.toString(), 'name');
    expect(newEmptyClass.login.toString(), 'login');
    expect(newEmptyClass.secret.toString(), 'secret');
    expect(newEmptyClass.secretConfirm.toString(), 'secretConfirm');
  });

  CreateAccountRequest createAccountRequest = CreateAccountRequest.empty();

  test('should be a instance of CreateAccountRequest', () {
    expect(createAccountRequest, isA<CreateAccountRequest>());
  });

  test('should return a error showing what is wrong in the field when not pass a value', () {
    expect(createAccountRequest.name.validator(), 'fill the field to submit');
  });

  test('should return a error showing what is wrong in the field when pass a value but only one word', () {
    createAccountRequest.setName('test');
    expect(createAccountRequest.name.validator(), 'fill it with full name');
  });

  test('should return null when pass a value with two words', () {
    createAccountRequest.setName('test test');
    expect(createAccountRequest.name.validator(), null);
  });

  test('should return a error showing what is wrong in the field when not pass a value', () {
    expect(createAccountRequest.login.validator(), 'fill the field to submit');
  });

  test('should return null when pass a value with one word', () {
    createAccountRequest.setLogin('test');
    expect(createAccountRequest.login.validator(), null);
  });

  test('should return a error showing what is wrong in the field when not pass a value', () {
    expect(createAccountRequest.secret.validator(), 'fill the field to submit');
  });

  test('should return null when pass a value with one word', () {
    createAccountRequest.setSecret('test');
    expect(createAccountRequest.secret.validator(), null);
  });

  test('should return a error showing what is wrong in the field when not pass a value', () {
    expect(createAccountRequest.secretConfirm.validator(), 'fill the field to submit');
  });

  test('should return null when pass a value with one word', () {
    createAccountRequest.setSecretConfirm('test');
    expect(createAccountRequest.secretConfirm.validator(), null);
  });

  test('should return a error showing what is wrong in the field when pass a value but not match with secret', () {
    createAccountRequest.setSecret('test');
    createAccountRequest.setSecretConfirm('test2');
    expect(createAccountRequest.secretConfirm.secretMatches(createAccountRequest.secret.toString()),
        'passwords do not match');
  });

  test('should return null when pass a secret equals to secretConfirm', () {
    createAccountRequest.setSecret('test');
    createAccountRequest.setSecretConfirm('test');
    expect(createAccountRequest.secretConfirm.validator(), null);
  });

  test('implements toJson', () {
    final createAccountRequest = CreateAccountRequest.empty();
    expect(createAccountRequest.toJson(), isA<Map<String, dynamic>>());
  });

  test('should return a json with the values of the fields', () {
    createAccountRequest.setName('test test');
    createAccountRequest.setLogin('test');
    createAccountRequest.setSecret('test');
    createAccountRequest.setSecretConfirm('test');
    expect(createAccountRequest.toJson(), {'userName': 'test', 'password': 'test', 'name': 'test test'});
  });
}

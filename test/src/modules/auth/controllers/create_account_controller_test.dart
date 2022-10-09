import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task/src/core/application/common_state.dart';
import 'package:task/src/core/application/create_account_request.dart';
import 'package:task/src/core/domain/repositories/login_repository.dart';
import 'package:task/src/core/services/form_validate_service.dart';
import 'package:task/src/modules/auth/controllers/create_account_controller.dart';

import '../../../core/services/http/http_service_dio_impl_test.dart';
import '../repositories/login_repository_impl_test.dart';

class BuildContextMock extends Mock implements BuildContext {}

class FormsValidateServiceMock extends Mock implements FormsValidateService {
  @override
  GlobalKey<FormState> get form => GlobalKey<FormState>();

  @override
  bool validate() {
    return true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final createAccountController = CreateAccountController(
    loginRepository: LoginRepositoryMock(HttpServiceMock()),
    formsValidate: FormsValidateServiceMock(),
  );

  test('should be a instance of CreateAccountController', () {
    expect(createAccountController, isA<CreateAccountController>());
  });

  test('should be a instance of CommonState, and be IdleState', () {
    expect(createAccountController.value, isA<IdleState>());
  });

  test('should be a instance of LoginRepository', () {
    expect(createAccountController.loginRepository, isA<LoginRepository>());
  });

  test('should be a instance of FormsValidateService', () {
    expect(createAccountController.formsValidate, isA<FormsValidateService>());
  });

  test('should be a instance of FocusNode', () {
    expect(createAccountController.loginFocus, isA<FocusNode>());
  });

  test('should be a instance of FocusNode', () {
    expect(createAccountController.secretFocus, isA<FocusNode>());
  });

  test('should be a instance of FocusNode', () {
    expect(createAccountController.secretConfirmFocus, isA<FocusNode>());
  });

  test('should be a instance of CreateAccountRequest', () {
    expect(createAccountController.newAccount, isA<CreateAccountRequest>());
  });

  test('should be a instance of GlobalKey<FormState>', () {
    expect(createAccountController.form, isA<GlobalKey<FormState>>());
  });

  test('should return error because no fields are filled in newaccount  when execute createNewAccountExecute',
      () async {
    createAccountController.createNewAccountExecute().then((value) {
      expect(createAccountController.value, isA<ErrorState>());
    });
  });

  test('should return success when execute createNewAccountExecute passing Login as test', () async {
    createAccountController.newAccount.setLogin('test');
    createAccountController.newAccount.setName('test');
    createAccountController.newAccount.setSecret('test');
    createAccountController.newAccount.setSecretConfirm('test');
    createAccountController.createNewAccountExecute().then((value) {
      expect(createAccountController.value, isA<SuccessState>());
    });
  });

  test('should return error when execute createNewAccountExecute passing Login as test2', () async {
    createAccountController.newAccount.setLogin('test2');
    createAccountController.newAccount.setName('test');
    createAccountController.newAccount.setSecret('test');
    createAccountController.newAccount.setSecretConfirm('test');
    createAccountController.createNewAccountExecute().then((value) {
      expect(createAccountController.value, isA<ErrorState>());
    });
  });

  test('should return error when execute createNewAccountExecute passing Login as test3', () async {
    createAccountController.newAccount.setLogin('test3');
    createAccountController.newAccount.setName('test');
    createAccountController.newAccount.setSecret('test');
    createAccountController.newAccount.setSecretConfirm('test');
    createAccountController.createNewAccountExecute().then((value) {
      expect(createAccountController.value, isA<ErrorState>());
    });
  });
}
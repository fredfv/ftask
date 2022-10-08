import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/application/common_state.dart';
import '../../../core/application/create_account_request.dart';
import '../../../core/services/form_validade_service.dart';
import '../repositories/login_repository_impl.dart';

class CreateAccountController extends ValueNotifier<CommonState> {
  final LoginRepositoryImpl loginRepository;
  final FormsValidateService formsValidate;
  FocusNode loginFocus = FocusNode();
  FocusNode secretFocus = FocusNode();
  FocusNode secretConfirmFocus = FocusNode();

  CreateAccountController({
    required this.loginRepository,
    required this.formsValidate,
  }) : super(IdleState());

  final newAccount = CreateAccountRequest.empty();

  GlobalKey<FormState> get form => formsValidate.form;

  void setLoginFocus(value) {
    loginFocus.requestFocus();
  }

  void setSecretFocus(value) {
    secretFocus.requestFocus();
  }

  void setSecretConfirmFocus(value) {
    secretConfirmFocus.requestFocus();
  }

  void createNewAccountExecute() {
    value = LoadingState();
    loginRepository.createAccount(newAccount).then((v) {
      if (v is Exception) {
        value = ErrorState(v.toString());
      } else {
        value = SuccessState<String>(response: 'account created! now login to start your tasks!');
        Modular.to.pop();
      }
    }).catchError((e) {
      value = ErrorState(e);
    });
  }

  void executeSubimitCreateAccount(BuildContext context) {
    if (formsValidate.validate()) {
      createNewAccountExecute();
    } else {
      value = ErrorState('invalid fields');
    }
  }
}

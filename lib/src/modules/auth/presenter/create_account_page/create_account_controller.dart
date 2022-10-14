import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/domain/repositories/repository_factory.dart';
import '../../../../core/domain/services/form_validate_service.dart';
import '../../../../core/domain/services/http_service.dart';
import '../../../../core/domain/usecases/create_account_usecase.dart';
import '../../../../core/infra/application/common_state.dart';
import '../../../../core/infra/application/create_account_request.dart';

class CreateAccountController extends ValueNotifier<CommonState> {
  final HttpService httpService;
  final RepositoryFactory repositoryFactory;
  final FormsValidateService formsValidate;
  final CreateAccountUsecase createAccountUseCase;
  FocusNode loginFocus = FocusNode();
  FocusNode secretFocus = FocusNode();
  FocusNode secretConfirmFocus = FocusNode();

  CreateAccountController({
    required this.httpService,
    required this.repositoryFactory,
    required this.formsValidate,
    required this.createAccountUseCase,
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

  Future createNewAccountExecute() async {
    value = LoadingState();
    createAccountUseCase.call(newAccount).then((v) {
      if (v is Exception || v == false) {
        value = ErrorState(v.toString());
      } else {
        value = SuccessState<String>(response: 'account created! now login to start your tasks!');
        Modular.to.pop();
      }
    }).catchError((e) {
      value = ErrorState(e);
    });
  }

  void executeSubmitCreateAccount() {
    if (formsValidate.validate()) {
      createNewAccountExecute();
    } else {
      value = ErrorState('invalid fields');
    }
  }
}

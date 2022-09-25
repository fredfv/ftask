import 'package:core/domain/application/common_state.dart';
import 'package:core/domain/application/create_account_request.dart';
import 'package:core/domain/presentation/color_outlet.dart';
import 'package:core/domain/services/display_snackbar_service.dart';
import 'package:core/domain/services/form_validade_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../repositories/login_repository_impl.dart';

class CreateAccountController extends ValueNotifier<CommonState> {
  final LoginRepositoryImpl loginRepository;
  final FormsValidateService formsValidate;
  final DisplaySnackbarService displaySnackbar;

  final newAccount = CreateAccountRequest.empty();

  FocusNode loginFocus = FocusNode();
  FocusNode secretFocus = FocusNode();
  FocusNode secretConfirmFocus = FocusNode();

  GlobalKey<FormState> get form => formsValidate.form;

  CreateAccountController({
    required this.loginRepository,
    required this.formsValidate,
    required this.displaySnackbar,
  }) : super(IdleState());

  void setLoginFocus(value) {
    loginFocus.requestFocus();
  }

  void setSecretFocus(value) {
    secretFocus.requestFocus();
  }

  void setSecretConfirmFocus(value) {
    secretConfirmFocus.requestFocus();
  }

  createNewAccountExecute() {
    value = LoadingState();
    loginRepository.createAccount(newAccount).then((v) {
      if (v is Exception) {
        value = ErrorState(v.toString());
      } else {
        value = SuccessState<String>(
            response: 'account created! now login to start your tasks!');
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
      displaySnackbar.show(context, 'invalid fields', ColorOutlet.error);
    }
  }
}

import 'package:auth/src/models/create_account_state.dart';
import 'package:core/domain/application/create_account_request.dart';
import 'package:core/domain/services/display_snackbar_service.dart';
import 'package:core/domain/services/form_validade_service.dart';
import 'package:core/infra/color_outlet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../repositories/login_repository_impl.dart';

class CreateAccountController extends ValueNotifier<CreateAccountState> {
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
  }) : super(CreateAccountIdle());

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
    value = CreateAccountLoading();
    loginRepository.createAccount(newAccount).then((v) {
      if (v is Exception) {
        value = CreateAccountError(v.toString());
      } else {
        Modular.to.pop();
      }
    }).catchError((e) {
      value = CreateAccountError(e);
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

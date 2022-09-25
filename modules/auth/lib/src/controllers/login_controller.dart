import 'package:core/domain/application/login_request.dart';
import 'package:core/domain/services/display_snackbar_service.dart';
import 'package:core/domain/services/form_validade_service.dart';
import 'package:core/infra/color_outlet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../models/login_state.dart';
import '../repositories/login_repository_impl.dart';

class LoginController extends ValueNotifier<LoginState> {
  final LoginRepositoryImpl loginRepository;
  final FormsValidateService formsValidate;
  final DisplaySnackbarService displaySnackbar;

  final FocusNode secretFocus = FocusNode();
  final loginRequest = LoginRequest.empty();

  GlobalKey<FormState> get form => formsValidate.form;

  LoginController({
    required this.loginRepository,
    required this.formsValidate,
    required this.displaySnackbar,
  }) : super(LoginIdle());

  executeLogin(BuildContext context) {
    if (formsValidate.validate()) {
      secretFocus.unfocus();
      value = LoginLoading();
      loginRepository.login(loginRequest).then((v) {
        if (v is Exception) {
          value = LoginError(v.toString());
        } else {
          loginRepository.persistAuthLogin(v).then((l) {
            value = LoginSucces('welcome ${v['person']['name']}');
            Modular.to.pushNamed('/task/');
          }).catchError((e) {
            value = LoginError(e.toString());
          });
        }
      }).catchError((e) {
        value = LoginError(e);
      });
    } else {
      displaySnackbar.show(context, 'invalid fields', ColorOutlet.error);
    }
  }

  void loginSubmitted(String value) {
    secretFocus.requestFocus();
  }

  void goToCreateAccount() {
    Modular.to.pushNamed('./createaccount');
  }
}

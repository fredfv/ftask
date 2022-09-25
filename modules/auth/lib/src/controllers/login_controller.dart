import 'package:core/domain/application/login_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../repositories/login_repository_impl.dart';
import '../models/login_state.dart';
import 'create_account_controller.dart';

class LoginController extends ValueNotifier<LoginState> {
  final LoginRepositoryImpl loginRepository;
  final FormsValidate formsValidate;
  final DisplaySnackbar displaySnackbar;

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
          displaySnackbar.show(context, 'welcome', Colors.green);
          value = LoginSucces();
          //Modular.to.pushNamed('/task/');
        }
      }).catchError((e) {
        value = LoginError(e);
      });
    } else {
      displaySnackbar.show(context, 'invalid fields', Colors.red);
    }
  }

  void loginSubmitted(String value) {
    secretFocus.requestFocus();
  }

  void goToCreateAccount(){
    Modular.to.pushNamed('./createaccount');
  }
}

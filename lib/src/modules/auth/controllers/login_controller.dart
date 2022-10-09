import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/application/common_state.dart';
import '../../../core/application/login_request.dart';
import '../../../core/services/form_validate_service.dart';
import '../repositories/login_repository_impl.dart';

class LoginController extends ValueNotifier<CommonState> {
  final LoginRepositoryImpl loginRepository;
  final FormsValidateService formsValidate;

  final FocusNode secretFocus = FocusNode();
  final loginRequest = LoginRequest.empty();

  GlobalKey<FormState> get form => formsValidate.form;

  LoginController({
    required this.loginRepository,
    required this.formsValidate,
  }) : super(IdleState());

  executeLogin(BuildContext context) {
    if (formsValidate.validate()) {
      secretFocus.unfocus();
      value = LoadingState();
      loginRepository.login(loginRequest).then((v) {
        if (v is Exception) {
          value = ErrorState(v.toString());
        } else {
          loginRepository.persistAuthLogin(v).then((l) {
            value = SuccessState<String>(response: 'welcome ${v['person']['name']}');
            Modular.to.navigate('/home/');
          }).catchError((e) {
            value = ErrorState(e.toString());
          });
        }
      }).catchError((e) {
        value = ErrorState(e);
      });
    } else {
      value = ErrorState('invalid fields');
    }
  }

  void loginSubmitted(String value) {
    secretFocus.requestFocus();
  }

  void goToCreateAccount() async {
    Modular.to.pushNamed('./createaccount');
  }
}
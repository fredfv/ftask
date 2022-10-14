import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/core/domain/repositories/repository_factory.dart';
import 'package:task/src/core/domain/use_cases/login_usecase.dart';

import '../../../core/application/common_state.dart';
import '../../../core/application/login_request.dart';
import '../../../core/services/form_validate_service.dart';
import '../../../core/domain/services/http_service.dart';

class LoginController extends ValueNotifier<CommonState> {
  final HttpService httpService;
  final RepositoryFactory repositoryFactory;
  final FormsValidateService formsValidate;
  final LoginUseCase loginUseCase;

  final FocusNode secretFocus = FocusNode();
  final loginRequest = LoginRequest.empty();

  GlobalKey<FormState> get form => formsValidate.form;

  LoginController({
    required this.httpService,
    required this.repositoryFactory,
    required this.formsValidate,
    required this.loginUseCase,
  }) : super(IdleState());

  executeLogin(BuildContext context) {
    if (formsValidate.validate()) {
      secretFocus.unfocus();
      value = LoadingState();
      loginUseCase.call(loginRequest).then((userEntity) {
        if (value is Exception || userEntity == null) {
          value = ErrorState(value.toString());
        } else {
          value = SuccessState();
          value = SuccessState<String>(response: 'welcome ${userEntity.name}');
          Modular.to.pushReplacementNamed('/home/');
        }
      }).catchError((e) {
        value = ErrorState(e.toString());
      });

      // loginRepository.login(loginRequest).then((v) {
      //   if (v is Exception) {
      //     value = ErrorState(v.toString());
      //   } else {
      //     loginRepository.persistAuthLogin(v).then((l) {
      //       value = SuccessState<String>(response: 'welcome ${v['person']['name']}');
      //       Modular.to.navigate('/home/');
      //     }).catchError((e) {
      //       value = ErrorState(e.toString());
      //     });
      //   }
      // }).catchError((e) {
      //   value = ErrorState(e);
      // });
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

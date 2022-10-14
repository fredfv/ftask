import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/domain/repositories/repository_factory.dart';
import '../../../../core/domain/services/form_validate_service.dart';
import '../../../../core/domain/services/http_service.dart';
import '../../../../core/domain/usecases/login_usecase.dart';
import '../../../../core/infra/application/common_state.dart';
import '../../../../core/infra/application/login_request.dart';

class LoginController extends ValueNotifier<CommonState> {
  final HttpService httpService;
  final RepositoryFactory repositoryFactory;
  final FormsValidateService formsValidate;
  final LoginUsecase loginUseCase;

  final FocusNode secretFocus = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController secretController = TextEditingController();

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
      LoginRequest loginRequest = LoginRequest(
        login: emailController.text,
        secret: secretController.text,
      );
      loginUseCase(loginRequest).then((userEntity) {
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

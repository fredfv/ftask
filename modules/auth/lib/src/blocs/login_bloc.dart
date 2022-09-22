import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/login_repository_impl.dart';
import 'events/login_event.dart';
import 'states/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepositoryImpl loginRepository;
  final TextEditingController loginController = TextEditingController();
  final TextEditingController secretController = TextEditingController();
  final FocusNode secretFocus = FocusNode();

  LoginBloc(this.loginRepository) : super(LoginIdle()) {
    on<LoginWithEmail>(loginEmail);
  }

  Future loginEmail(LoginWithEmail event, Emitter<LoginState> emit) async {
    secretFocus.unfocus();
    emit(LoginLoading());
    await Future.delayed(const Duration(seconds: 7));
    try {
      await loginRepository.login(event.email, event.secret);
      emit(LoginFailure('error login'));
    } catch (e) {
      emit(LoginFailure('error login'));
    }
  }

  void loginSubmitted(String value) {
    secretFocus.requestFocus();
  }

  void secretSubmitted(String value) {
    add(LoginWithEmail(
        email: loginController.text, secret: secretController.text));
  }
}

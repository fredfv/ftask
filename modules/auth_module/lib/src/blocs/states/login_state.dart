abstract class LoginState {}

class LoginIdle implements LoginState {}

class LoginSucces implements LoginState {}

class LoginLoading implements LoginState {}

class LoginFailure implements LoginState {
  final String message;

  LoginFailure(this.message);
}

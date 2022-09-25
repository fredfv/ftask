abstract class LoginState {}

class LoginIdle implements LoginState {}

class LoginSucces implements LoginState {}

class LoginLoading implements LoginState {}

class LoginError implements LoginState {
  final String message;

  LoginError(this.message);
}

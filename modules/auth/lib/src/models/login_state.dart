abstract class LoginState {}

class LoginIdle implements LoginState {}

class LoginSucces implements LoginState {
  final String message;

  LoginSucces(this.message);
}

class LoginLoading implements LoginState {}

class LoginError implements LoginState {
  final String message;

  LoginError(this.message);
}

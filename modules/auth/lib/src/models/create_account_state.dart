abstract class CreateAccountState {}

class CreateAccountIdle extends CreateAccountState {}

class CreateAccountLoading extends CreateAccountState {}

class CreateAccountError extends CreateAccountState {
  final String message;

  CreateAccountError(this.message);
}

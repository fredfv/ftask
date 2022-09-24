abstract class CreateAccountState {}

class Idle extends CreateAccountState {}

class Loading extends CreateAccountState {}

class Error extends CreateAccountState {
  final String message;

  Error(this.message);
}

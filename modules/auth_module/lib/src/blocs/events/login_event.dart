abstract class LoginEvent{}
class LoginWithEmail implements LoginEvent{
  final String secret;
  final String email;

  LoginWithEmail({required this.secret, required this.email});
}
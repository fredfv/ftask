import '../../application/create_account_request.dart';

abstract class CreateAccountUseCase {
  Future<bool> call(CreateAccountRequest newAccount);
}

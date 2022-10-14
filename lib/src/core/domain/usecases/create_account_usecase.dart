import '../../infra/application/create_account_request.dart';

abstract class CreateAccountUsecase {
  Future<bool> call(CreateAccountRequest newAccount);
}

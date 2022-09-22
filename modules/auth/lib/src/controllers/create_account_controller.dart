import 'package:core/domain/application/create_account_dto.dart';
import 'package:core/domain/value_objects/secret_vo.dart';
import 'package:flutter/cupertino.dart';

import '../repositories/login_repository_impl.dart';

enum CreateAccountState {
  error,
  sucess,
  idle,
  loading,
}

class CreateAccountController extends ChangeNotifier {
  final LoginRepositoryImpl loginRepository;

  CreateAccountController(this.loginRepository);

  var state = CreateAccountState.idle;

  Future<void> createNewAccountExecute(CreateAccountDTO newUser) async {
    state = CreateAccountState.loading;
    try {
      await loginRepository.createAccount(
        newUser.login.toString(),
        newUser.secret.toString(),
        newUser.name.toString(),
      );
      state = CreateAccountState.sucess;
    } catch (e) {
      state = CreateAccountState.error;
    }

    notifyListeners();
  }
}

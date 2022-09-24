import 'package:auth/src/models/create_account_state.dart';
import 'package:core/domain/application/create_account_dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http_dio/helpers/logger.dart';
import '../repositories/login_repository_impl.dart';

class CreateAccountController extends ValueNotifier<CreateAccountState> {
  final LoginRepositoryImpl loginRepository;
  final newAccount = CreateAccountDTO.empty();
  final formKey = GlobalKey<FormState>();

  FocusNode loginFocus = FocusNode();
  FocusNode secretFocus = FocusNode();
  FocusNode secretConfirmFocus = FocusNode();

  FormState get form => formKey.currentState!;

  CreateAccountController(this.loginRepository) : super(CreateAccountIdle());

  void setLoginFocus(value) {
    loginFocus.requestFocus();
  }

  void setSecretFocus(value) {
    secretFocus.requestFocus();
  }

  void setSecretConfirmFocus(value) {
    secretConfirmFocus.requestFocus();
  }

  createNewAccountExecute() {
    value = CreateAccountLoading();
    loginRepository.createAccount(newAccount).then((v) {
      if (v is Exception) {
        value = CreateAccountError(v.toString());
      } else {
        Modular.to.pop();
      }
    }).catchError((e) {
      value = CreateAccountError(e);
    });
  }

  void subimitExecute(BuildContext context) {
    final valid = form.validate();
    if (valid) {
      createNewAccountExecute();
    } else {
      showSnackError(context, 'invalid fields', Colors.red);
    }
  }

  void showSnackError(BuildContext context, String msg, Color cor) {
    var snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.red,
    );
    Future.delayed(const Duration(milliseconds: 150), () {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}

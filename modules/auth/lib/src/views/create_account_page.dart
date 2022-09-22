import 'package:auth/src/controllers/create_account_controller.dart';
import 'package:auth/src/views/widgets/create_account_button.dart';

//import 'package:brasil_fields/brasil_fields.dart';
import 'package:core/domain/application/create_account_dto.dart';
import 'package:core/domain/repositories/color_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'widgets/create_account_entry.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final controller = Modular.get<CreateAccountController>();
  final newAccount = CreateAccountDTO.empty();
  final formKey = GlobalKey<FormState>();

  FormState get form => formKey.currentState!;

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);

    controller.addListener(() {
      if (controller.state == CreateAccountState.sucess) {
        Modular.to.pop();
      } else if (controller.state == CreateAccountState.error) {
        showSnackError('Ocorreu um erro no servidor', Colors.red);
      } else if (controller.state == CreateAccountState.loading) {
        showSnackError('Aguarde', Colors.green);
      }
    });

    // WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  void showSnackError(String msg, Color cor) {
    const snackBar = SnackBar(
      content: Text('Invalid fields'),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void listener() {
    setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    //controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRepository.primary,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create new account'),
        backgroundColor: ColorRepository.primary,
        iconTheme: const IconThemeData(
          color: ColorRepository.secondary,
        ),
        titleTextStyle: TextStyle(
            fontFamily: 'Sansation',
            color: ColorRepository.secondary,
            fontSize: MediaQuery.of(context).size.width /
                MediaQuery.of(context).size.height *
                35),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            CreateAccountEntry(
              label: 'Name',
              value: newAccount.name.toString(),
              validator: (v) => newAccount.name.validator(),
              onChanged: newAccount.setName,
            ),
            CreateAccountEntry(
              label: 'Login',
              value: newAccount.login.toString(),
              validator: (v) => newAccount.login.validator(),
              onChanged: newAccount.setLogin,
              //inputFormatters: [CpfInputFormatter()],
            ),
            CreateAccountEntry(
              label: 'Password',
              value: newAccount.name.toString(),
              validator: (v) => newAccount.secret.validator(),
              onChanged: newAccount.setSecret,
              obscureText: true,
            ),
            // CreateAccountEntry(
            //   label: 'Confirm password',
            //   value: SecretVO('').toString(),
            //   validator: controller.confirmPassword.validator,
            //   onChanged: controller.s,
            //   obscureText: true,
            // )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
        child: CreateAccountButton(
          onPressed: () {
            final valid = form.validate();

            if (valid) {
              controller.createNewAccountExecute(newAccount);
            } else {
              showSnackError('error', Colors.red);
            }
          },
        ),
      ),
    );
  }
}

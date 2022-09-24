import 'package:auth/src/controllers/create_account_controller.dart';
import 'package:auth/src/views/widgets/submit_account_button.dart';
import 'package:core/domain/repositories/color_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../models/create_account_state.dart';
import 'widgets/create_account_entry.dart';

class CreateAccountPage extends StatelessWidget {
  CreateAccountPage({Key? key}) : super(key: key);
  final controller = Modular.get<CreateAccountController>();

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
        key: controller.formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.width * 0.01,
            horizontal: MediaQuery.of(context).size.height * 0.03,
          ),
          children: [
            CreateAccountEntry(
              onFieldSubmitted: controller.setLoginFocus,
              label: 'Name',
              value: controller.newAccount.name.toString(),
              validator: (v) => controller.newAccount.name.validator(),
              onChanged: controller.newAccount.setName,
            ),
            CreateAccountEntry(
              onFieldSubmitted: controller.setSecretFocus,
              focusNode: controller.loginFocus,
              label: 'Login',
              value: controller.newAccount.login.toString(),
              validator: (v) => controller.newAccount.login.validator(),
              onChanged: controller.newAccount.setLogin,
              //inputFormatters: [CpfInputFormatter()],
            ),
            CreateAccountEntry(
              onFieldSubmitted: controller.setSecretConfirmFocus,
              focusNode: controller.secretFocus,
              label: 'Password',
              value: controller.newAccount.secret.toString(),
              validator: (v) => controller.newAccount.secret.validator(),
              onChanged: controller.newAccount.setSecret,
              obscureText: true,
            ),
            CreateAccountEntry(
              focusNode: controller.secretConfirmFocus,
              label: 'Confirm password',
              value: controller.newAccount.secretConfirm.toString(),
              validator: (v) => controller.newAccount.secretConfirm
                  .secretMatches(controller.newAccount.secret.toString()),
              onChanged: controller.newAccount.setSecretConfirm,
              obscureText: true,
            ),
            ValueListenableBuilder(
              valueListenable: controller,
              builder: (_, state, child) {
                if (state is Error) {
                  controller.showSnackError(context, state.message, Colors.red);
                  controller.value = Idle();
                } else if (state is Loading) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.width * 0.07,
                      horizontal: MediaQuery.of(context).size.height * 0.07,
                    ),
                    child: LoadingAnimationWidget.dotsTriangle(
                      color: ColorRepository.secondary,
                      size: MediaQuery.of(context).size.width /
                          MediaQuery.of(context).size.height *
                          100,
                    ),
                  );
                }
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width * 0.07,
                    horizontal: MediaQuery.of(context).size.height * 0.07,
                  ),
                  child: SubimitAccountButton(
                    onPressed: () {
                      controller.subimitExecute(context);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

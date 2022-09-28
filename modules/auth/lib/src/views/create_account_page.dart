import 'package:auth/src/controllers/create_account_controller.dart';
import 'package:core/domain/application/common_state.dart';
import 'package:core/domain/presentation/color_outlet.dart';
import 'package:core/domain/presentation/widgets/common_button.dart';
import 'package:core/domain/presentation/widgets/common_text_form_field.dart';
import 'package:core/domain/presentation/widgets/common_widgets.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatelessWidget {
  final CreateAccountController controller;

  const CreateAccountPage({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorOutlet.primary,
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Create new account'),
          backgroundColor: ColorOutlet.primary,
          iconTheme: const IconThemeData(color: ColorOutlet.secondary),
          titleTextStyle: TextStyle(
              fontFamily: 'Sansation',
              color: ColorOutlet.secondary,
              fontSize: MediaQuery.of(context).size.width /
                  MediaQuery.of(context).size.height *
                  35)),
      body: Form(
        key: controller.form,
        child: ListView(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.03,
              horizontal: MediaQuery.of(context).size.width * 0.05),
          children: [
            CommonTextFormField(
                onFieldSubmitted: controller.setLoginFocus,
                label: 'Name',
                value: controller.newAccount.name.toString(),
                validator: (v) => controller.newAccount.name.validator(),
                onChanged: controller.newAccount.setName),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            CommonTextFormField(
                onFieldSubmitted: controller.setSecretFocus,
                focusNode: controller.loginFocus,
                label: 'Login',
                value: controller.newAccount.login.toString(),
                validator: (v) => controller.newAccount.login.validator(),
                onChanged: controller.newAccount.setLogin),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            CommonTextFormField(
                onFieldSubmitted: controller.setSecretConfirmFocus,
                focusNode: controller.secretFocus,
                label: 'Password',
                value: controller.newAccount.secret.toString(),
                validator: (v) => controller.newAccount.secret.validator(),
                onChanged: controller.newAccount.setSecret,
                obscureText: true),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            CommonTextFormField(
                onFieldSubmitted: (value) =>
                    controller.executeSubimitCreateAccount(context),
                focusNode: controller.secretConfirmFocus,
                label: 'Confirm password',
                value: controller.newAccount.secretConfirm.toString(),
                validator: (v) => controller.newAccount.secretConfirm
                    .secretMatches(controller.newAccount.secret.toString()),
                onChanged: controller.newAccount.setSecretConfirm,
                obscureText: true),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.05),
              child: ValueListenableBuilder(
                valueListenable: controller,
                builder: (_, state, child) {
                  if (state is LoadingState) {
                    return CommonWidgets.loadingAnimationWidgetForButtons(
                        context);
                  } else if (state is SuccessState) {
                    controller.displaySnackbar
                        .show(context, state.response, ColorOutlet.success);
                    controller.value = IdleState();
                  } else if (state is ErrorState) {
                    controller.displaySnackbar
                        .show(context, state.message, ColorOutlet.error);
                    controller.value = IdleState();
                  }
                  return CommonButton(
                    description: 'Subimit new account',
                    onPressed: () {
                      controller.executeSubimitCreateAccount(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

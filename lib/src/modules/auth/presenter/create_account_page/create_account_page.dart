import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../core/infra/application/common_state.dart';
import '../../../../core/presenter/shared/common_button.dart';
import '../../../../core/presenter/shared/common_loading.dart';
import '../../../../core/presenter/shared/common_snackbar.dart';
import '../../../../core/presenter/shared/common_text_form_field.dart';
import '../../../../core/presenter/theme/color_outlet.dart';
import '../../../../core/presenter/theme/size_outlet.dart';
import 'create_account_controller.dart';

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
                initialValue: controller.newAccount.name.toString(),
                validator: (v) => controller.newAccount.name.validator(),
                onChanged: controller.newAccount.setName),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            CommonTextFormField(
                onFieldSubmitted: controller.setSecretFocus,
                focusNode: controller.loginFocus,
                label: 'Login',
                initialValue: controller.newAccount.login.toString(),
                validator: (v) => controller.newAccount.login.validator(),
                onChanged: controller.newAccount.setLogin),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            CommonTextFormField(
                onFieldSubmitted: controller.setSecretConfirmFocus,
                focusNode: controller.secretFocus,
                label: 'Password',
                initialValue: controller.newAccount.secret.toString(),
                validator: (v) => controller.newAccount.secret.validator(),
                onChanged: controller.newAccount.setSecret,
                obscureText: true),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            CommonTextFormField(
                onFieldSubmitted: (value) =>
                    controller.executeSubmitCreateAccount(),
                focusNode: controller.secretConfirmFocus,
                label: 'Confirm password',
                initialValue: controller.newAccount.secretConfirm.toString(),
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
                    return const CommonLoading(SizeOutlet.loadingForButtons);
                  } else if (state is SuccessState) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(CommonSnackBar(
                          content: Text(state.response.toString()),
                          backgroundColor: ColorOutlet.success));
                      controller.value = IdleState();
                    });
                  } else if (state is ErrorState) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(CommonSnackBar(
                          content: Text(state.message),
                          backgroundColor: ColorOutlet.error));
                      controller.value = IdleState();
                    });
                  }
                  return CommonButton(
                    description: 'Subimit new account',
                    onPressed: () {
                      controller.executeSubmitCreateAccount();
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

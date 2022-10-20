import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:task/src/core/infra/validators/secret_validator.dart';
import 'package:task/src/core/presenter/shared/common_spacing.dart';

import '../../../../core/infra/application/common_state.dart';
import '../../../../core/infra/validators/string_validator.dart';
import '../../../../core/presenter/shared/common_button.dart';
import '../../../../core/presenter/shared/common_loading.dart';
import '../../../../core/presenter/shared/common_snackbar.dart';
import '../../../../core/presenter/shared/common_text_form_field.dart';
import '../../../../core/presenter/theme/color_outlet.dart';
import '../../../../core/presenter/theme/font_family_outlet.dart';
import '../../../../core/presenter/theme/lexicon.dart';
import '../../../../core/presenter/theme/responsive_outlet.dart';
import '../../../../core/presenter/theme/size_outlet.dart';
import 'create_account_controller.dart';

class CreateAccountPage extends StatelessWidget {
  final CreateAccountController controller;

  const CreateAccountPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorOutlet.primary,
      appBar: AppBar(
          centerTitle: true,
          title: const Text(Lexicon.createAccount),
          backgroundColor: ColorOutlet.primary,
          iconTheme: const IconThemeData(color: ColorOutlet.secondary),
          titleTextStyle: TextStyle(
            fontFamily: FontFamilyOutlet.sensation,
            color: ColorOutlet.secondary,
            fontSize: ResponsiveOutlet.textDefault(context),
          )),
      body: Form(
        key: controller.form,
        child: ListView(
          padding: EdgeInsets.all(ResponsiveOutlet.paddingLarge(context)),
          children: [
            CommonTextFormField(
              onFieldSubmitted: controller.setLoginFocus,
              label: Lexicon.name,
              validator: (v) => StringValidator(v).validate(),
              controller: controller.nameController,
            ),
            CommonSpacing.height(factor: SizeOutlet.spacingFactor3),
            CommonTextFormField(
              onFieldSubmitted: controller.setSecretFocus,
              focusNode: controller.loginFocus,
              label: Lexicon.login,
              validator: (v) => StringValidator(v).validate(),
              controller: controller.loginController,
            ),
            CommonSpacing.height(factor: SizeOutlet.spacingFactor3),
            CommonTextFormField(
              onFieldSubmitted: controller.setSecretConfirmFocus,
              focusNode: controller.secretFocus,
              label: Lexicon.secret,
              validator: (v) => StringValidator(v).validate(),
              controller: controller.secretController,
              obscureText: true,
            ),
            CommonSpacing.height(factor: SizeOutlet.spacingFactor3),
            CommonTextFormField(
              onFieldSubmitted: controller.executeSubmitCreateAccount,
              focusNode: controller.secretConfirmFocus,
              label: Lexicon.secretConfirm,
              validator: (v) => SecretValidator(v).secretMatches(controller.secretController.text),
              controller: controller.secretConfirmController,
              obscureText: true,
            ),
            CommonSpacing.height(factor: SizeOutlet.spacingFactor3),
            Padding(
              padding: EdgeInsets.symmetric(vertical: ResponsiveOutlet.paddingDefault(context)),
              child: ValueListenableBuilder(
                valueListenable: controller,
                builder: (_, state, child) {
                  if (state is LoadingState) {
                    return const CommonLoading(SizeOutlet.loadingForButtons);
                  } else if (state is SuccessState) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        CommonSnackBar(
                          content: Text(state.response.toString()),
                          backgroundColor: ColorOutlet.success,
                        ),
                      );
                      controller.value = IdleState();
                    });
                  } else if (state is ErrorState) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        CommonSnackBar(
                          content: Text(state.message),
                          backgroundColor: ColorOutlet.error,
                        ),
                      );
                      controller.value = IdleState();
                    });
                  }
                  return CommonButton(
                      description: Lexicon.submitAccount,
                      onPressed: () {
                        controller.executeSubmitCreateAccount(null);
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

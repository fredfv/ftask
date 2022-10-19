import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/src/core/infra/validators/secret_validator.dart';
import 'package:task/src/core/infra/validators/string_validator.dart';
import 'package:task/src/core/presenter/shared/common_spacing.dart';

import '../../../../core/infra/application/common_state.dart';
import '../../../../core/presenter/shared/common_button.dart';
import '../../../../core/presenter/shared/common_loading.dart';
import '../../../../core/presenter/shared/common_snackbar.dart';
import '../../../../core/presenter/shared/common_text_form_field.dart';
import '../../../../core/presenter/shared/underline_button.dart';
import '../../../../core/presenter/theme/color_outlet.dart';
import '../../../../core/presenter/theme/lexicon.dart';
import '../../../../core/presenter/theme/responsive_outlet.dart';
import '../../../../core/presenter/theme/size_outlet.dart';
import '../../../../core/presenter/theme/spacing_type.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller;

  const LoginPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorOutlet.primary,
      body: Form(
        key: controller.form,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(ResponsiveOutlet.paddingExtraLarge(context)),
          children: [
            SvgPicture.asset(
              'assets/ttlogo.svg',
              color: ColorOutlet.secondary,
              width: ResponsiveOutlet.aspectRatioSizeable(context, SizeOutlet.imageSize),
            ),
            CommonTextFormField(
              onFieldSubmitted: controller.loginSubmitted,
              label: Lexicon.login,
              validator: (v) => StringValidator(v).validate(),
              controller: controller.emailController,
            ),
            const CommonSpacing(SpacingType.height),
            CommonTextFormField(
                onFieldSubmitted: (value) => controller.executeLogin(context),
                label: Lexicon.secret,
                validator: (v) => StringValidator(v).validate(),
                controller: controller.secretController,
                focusNode: controller.secretFocus,
                obscureText: true),
            Padding(
              padding: EdgeInsets.symmetric(vertical: ResponsiveOutlet.paddingSmall(context)),
              child: ValueListenableBuilder(
                  valueListenable: controller,
                  builder: (_, state, child) {
                    if (state is LoadingState) {
                      return CommonLoading(
                          ResponsiveOutlet.loadingResponsiveSize(context, SizeOutlet.loadingForButtons));
                    } else if (state is SuccessState) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(CommonSnackBar(
                            content: Text(state.response.toString()), backgroundColor: ColorOutlet.success));
                        controller.value = IdleState();
                      });
                    } else if (state is ErrorState) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CommonSnackBar(content: Text(state.message), backgroundColor: ColorOutlet.error));
                        controller.value = IdleState();
                      });
                    }
                    return CommonButton(
                        description: Lexicon.loginAccount, onPressed: () => controller.executeLogin(context));
                  }),
            ),
            Center(
                child: UnderLineButton(
                    onPressed: () => controller.goToCreateAccount(), description: Lexicon.createAccount.toLowerCase()))
          ],
        ),
      ),
    );
  }
}

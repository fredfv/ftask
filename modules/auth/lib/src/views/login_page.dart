import 'package:core/domain/presentation/widgets/common_text_form_field.dart';
import 'package:core/domain/presentation/widgets/login_button.dart';
import 'package:core/domain/presentation/widgets/underline_button.dart';
import 'package:core/domain/application/common_state.dart';
import 'package:core/domain/presentation/color_outlet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/login_controller.dart';

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
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.03,
            horizontal: MediaQuery.of(context).size.width * 0.05,
          ),
          children: [
            SvgPicture.asset(
              'assets/ttlogo.svg',
              color: ColorOutlet.secondary,
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            CommonTextFormField(
              onFieldSubmitted: controller.loginSubmitted,
              label: 'Login',
              value: controller.loginRequest.login.toString(),
              validator: (v) => controller.loginRequest.login.validator(),
              onChanged: controller.loginRequest.setLogin,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            CommonTextFormField(
              onFieldSubmitted: (value) => controller.executeLogin(context),
              focusNode: controller.secretFocus,
              label: 'Password',
              value: controller.loginRequest.secret.toString(),
              validator: (v) => controller.loginRequest.secret.validator(),
              onChanged: controller.loginRequest.setSecret,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.05,
              ),
              child: ValueListenableBuilder(
                  valueListenable: controller,
                  builder: (_, state, child) {
                    if (state is LoadingState) {
                      return Center(
                        child: LoadingAnimationWidget.dotsTriangle(
                            color: ColorOutlet.secondary,
                            size: MediaQuery.of(context).size.width /
                                MediaQuery.of(context).size.height *
                                70),
                      );
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
                      description: 'Log in',
                      onPressed: () => controller.executeLogin(context),
                    );
                  }),
            ),
            Center(
                child: UnderLineButton(
              onPressed: () => controller.goToCreateAccount(),
              description: 'create account',
            ))
          ],
        ),
      ),
    );
  }
}

import 'package:auth/src/views/widgets/create_account_button.dart';
import 'package:auth/src/views/widgets/create_account_entry.dart';
import 'package:core/domain/repositories/color_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/login_controller.dart';
import '../models/login_state.dart';
import 'widgets/login_button.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller;

  const LoginPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRepository.primary,
      body: Form(
        key: controller.form,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.05,
              MediaQuery.of(context).size.height * 0.07,
              MediaQuery.of(context).size.width * 0.05,
              MediaQuery.of(context).size.height * 0.05),
          children: [
            SvgPicture.asset(
              'assets/ttlogo.svg',
              color: ColorRepository.secondary,
              width: MediaQuery.of(context).size.width * 0.7,
            ),
            CreateAccountEntry(
              onFieldSubmitted: controller.loginSubmitted,
              label: 'Login',
              value: controller.loginRequest.login.toString(),
              validator: (v) => controller.loginRequest.login.validator(),
              onChanged: controller.loginRequest.setLogin,
            ),
            CreateAccountEntry(
              onFieldSubmitted: (value) => controller.executeLogin(context),
              focusNode: controller.secretFocus,
              label: 'Password',
              value: controller.loginRequest.secret.toString(),
              validator: (v) => controller.loginRequest.secret.validator(),
              onChanged: controller.loginRequest.setSecret,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03,
                  left: MediaQuery.of(context).size.width * 0.13,
                  right: MediaQuery.of(context).size.width * 0.13),
              child: ValueListenableBuilder(
                  valueListenable: controller,
                  builder: (_, state, child) {
                    if (state is LoginLoading) {
                      return Center(
                        child: LoadingAnimationWidget.dotsTriangle(
                            color: ColorRepository.secondary,
                            size: MediaQuery.of(context).size.width /
                                MediaQuery.of(context).size.height *
                                70),
                      );
                    }

                    return LoginButton(
                        onPressed: () => controller.executeLogin(context));
                  }),
            ),
            Center(
                child: CreateAccountButton(
                    onPressed: () => controller.goToCreateAccount()))
          ],
        ),
      ),
    );
  }
}

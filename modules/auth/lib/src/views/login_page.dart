import 'package:core/domain/application/common_state.dart';
import 'package:core/domain/presentation/color_outlet.dart';
import 'package:core/domain/presentation/size_outlet.dart';
import 'package:core/domain/presentation/widgets/common_button.dart';
import 'package:core/domain/presentation/widgets/common_loading.dart';
import 'package:core/domain/presentation/widgets/common_snackbar.dart';
import 'package:core/domain/presentation/widgets/common_text_form_field.dart';
import 'package:core/domain/presentation/widgets/underline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              horizontal: MediaQuery.of(context).size.width * 0.05),
          children: [
            SvgPicture.asset('assets/ttlogo.svg',
                color: ColorOutlet.secondary,
                width: MediaQuery.of(context).size.width * 0.7),
            CommonTextFormField(
                onFieldSubmitted: controller.loginSubmitted,
                label: 'Login',
                value: controller.loginRequest.login.toString(),
                validator: (v) => controller.loginRequest.login.validator(),
                onChanged: controller.loginRequest.setLogin),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            CommonTextFormField(
                onFieldSubmitted: (value) => controller.executeLogin(context),
                label: 'Password',
                value: controller.loginRequest.secret.toString(),
                validator: (v) => controller.loginRequest.secret.validator(),
                onChanged: controller.loginRequest.setSecret,
                focusNode: controller.secretFocus,
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
                        ScaffoldMessenger.of(context).showSnackBar(
                            CommonSnackBar(
                                content: Text(state.response.toString()),
                                backgroundColor: ColorOutlet.success));
                        controller.value = IdleState();
                      });
                    } else if (state is ErrorState) {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CommonSnackBar(
                                content: Text(state.message),
                                backgroundColor: ColorOutlet.error));
                        controller.value = IdleState();
                      });
                    }
                    return CommonButton(
                        description: 'Log in',
                        onPressed: () => controller.executeLogin(context));
                  }),
            ),
            Center(
                child: UnderLineButton(
                    onPressed: () => controller.goToCreateAccount(),
                    description: 'create account'))
          ],
        ),
      ),
    );
  }
}

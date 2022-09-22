import 'package:core/domain/repositories/color_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../blocs/events/login_event.dart';
import '../blocs/login_bloc.dart';
import '../blocs/states/login_state.dart';
import 'widgets/login_button.dart';
import 'widgets/login_entry.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bloc = Modular.get<LoginBloc>();

  @override
  void initState() {
    super.initState();

    bloc.stream.listen((state) async {
      if (state is LoginSucces) {
        await Future.delayed(const Duration(milliseconds: 500));
        Modular.to.navigate('/task/');
      }

      if (state is LoginFailure) {
        const snack = SnackBar(
          content: Text('Error login'),
        );

        if (mounted) ScaffoldMessenger.of(context).showSnackBar(snack);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRepository.primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.05,
              MediaQuery.of(context).size.height * 0.07,
              MediaQuery.of(context).size.width * 0.05,
              MediaQuery.of(context).size.height * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/ttlogo.svg',
                color: ColorRepository.secondary,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
              LoginEntry(
                controller: bloc.loginController,
                onFieldSubmitted: bloc.loginSubmitted,
                obscureText: false,
                icon: Icons.alternate_email,
                hintText: 'Login com email',
                labeltext: 'Login',
              ),
              LoginEntry(
                focusNode: bloc.secretFocus,
                controller: bloc.secretController,
                onFieldSubmitted: bloc.secretSubmitted,
                obscureText: true,
                icon: Icons.password,
                hintText: 'Senha',
                labeltext: 'Password',
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03),
                child: BlocBuilder<LoginBloc, LoginState>(
                    bloc: bloc,
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return Center(
                          child: LoadingAnimationWidget.dotsTriangle(
                            color: ColorRepository.secondary,
                            size: MediaQuery.of(context).size.width /
                                MediaQuery.of(context).size.height *
                                70,
                          ),
                        );
                      }
                      if (state is LoginSucces) {
                        return const Center(
                          child: Text('Entrou'),
                        );
                      }
                      return LoginButton(onPressed: () {
                        bloc.add(LoginWithEmail(
                            email: bloc.loginController.text,
                            secret: bloc.secretController.text));
                      });
                    }),
              ),
              InkWell(
                onTap: () async {
                  await Modular.to.pushNamed('./createaccount');
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.07),
                  child: const Text(
                    'create account',
                    style: TextStyle(
                        color: ColorRepository.secondaryDark,
                        decoration: TextDecoration.underline),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

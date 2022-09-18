import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../blocs/events/login_event.dart';
import '../blocs/login_bloc.dart';
import '../blocs/states/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

//class _LoginPageState extends ModularState<LoginPage, LoginBloc>{
class _LoginPageState extends State<LoginPage> {
  final bloc = Modular.get<LoginBloc>();

  @override
  void initState() {
    super.initState();
    bloc.stream.listen((state) async {
      if (state is LoginSucces) {
        await Future.delayed(const Duration(milliseconds: 500));
        Modular.to.navigate('/task/red');
      }

      if (state is LoginFailure) {
        const snack = SnackBar(
          content: Text('Error login'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snack);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LoginSucces) {
              return const Center(
                child: Text('Entrou'),
              );
            }
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  bloc.add(LoginWithEmail(secret: '123', email: 'adm'));
                },
                child: const Text('Entrar'),
              ),
            );
          }),
    );
  }
}

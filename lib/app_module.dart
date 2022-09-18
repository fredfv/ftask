import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/modules/auth/auth_module.dart';
import 'package:task/splash_page.dart';
import 'package:task/src/modules/auth/guards/auth_guards.dart';
import 'package:task/src/modules/task/task_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  //TRANSITIONS DENTRO DA CADEIA DE MODULE VAI RESPEITAR O PAI
  //A PRIMEIRA ROTA NAO TEM ANIMACAO
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => const SplashPage()),
    ModuleRoute('/auth', module: AuthModule()),
    ModuleRoute('/task', module: TaskModule(), guards: [AuthGuard()]),
    WildcardRoute(
        child: (_, __) => const Scaffold(
                body: Center(
              child: Text('Página não existe'),
            )))
    //RedirectRoute('/redir', to: '/auth/')
  ];
}

import 'package:auth_module/auth_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/splash_page.dart';
import 'package:task/src/modules/task/task_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
    AsyncBind((i) => SharedPreferences.getInstance()),
  ];

  //TRANSITIONS DENTRO DA CADEIA DE MODULE VAI RESPEITAR O PAI
  //A PRIMEIRA ROTA NAO TEM ANIMACAO
  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => const SplashPage()),
    ModuleRoute('/src', module: AuthModule()),
    ModuleRoute('/task', module: TaskModule(), guards: [AuthGuard()]),
    WildcardRoute(
        child: (_, __) => const Scaffold(
                body: Center(
              child: Text('Página não existe'),
            )))
    //RedirectRoute('/redir', to: '/auth/')
  ];
}

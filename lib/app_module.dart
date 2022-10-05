import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/splash_page.dart';
import 'package:task/src/modules/task/task_module.dart';

import 'src/core/services/http/http_service_dio_impl.dart';
import 'src/core/ui/services/forms_validade_impl.dart';
import 'src/modules/auth/auth_module.dart';
import 'src/modules/auth/guards/auth_guards.dart';
import 'src/modules/auth/repositories/login_repository_impl.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => LoginRepositoryImpl(i())),
        Bind.factory((i) => FormsValidateImpl()),
        Bind.lazySingleton((i) => HttpServiceDioImpl()),
      ];

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

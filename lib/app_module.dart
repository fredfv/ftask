import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/modules/auth/auth_module.dart';
import 'package:task/splash_page.dart';
import 'package:task/src/modules/task/task_module.dart';

class AppModule extends Module{
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => const SplashPage()),
    ModuleRoute('/auth', module: AuthModule()),
    ModuleRoute('/task', module: TaskModule()),
  ];
}
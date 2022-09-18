import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/modules/auth/views/login_page.dart';

class AuthModule extends Module{
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, __) => const LoginPage())
  ];
}
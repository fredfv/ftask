import 'package:flutter_modular/flutter_modular.dart';

import 'blocs/login_bloc.dart';
import 'repositories/login_repository.dart';
import 'views/login_page.dart';

class AuthModule extends Module {
  //FACTORY, SEMPRE QUE CHAMAR ELE VAI CRIAR UM NOVO
  //INTANCIA, ELE SEMPRE VAI PEGAR A INSTANCIA
  //SINGLETON SERIIZADO E INICIADO
  //LAZY SINGLETON INICIADO SOMENTE QUANDO CHAMA A PRIMEIRA VEZ
  @override
  List<Bind> get binds => [
        Bind.factory((i) => LoginRepository()),
        Bind.singleton((i) => LoginBloc(i(), i()))
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute('/', child: (_, __) => const LoginPage())];
}

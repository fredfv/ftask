import 'package:flutter_modular/flutter_modular.dart';

import 'blocs/login_bloc.dart';
import 'repositories/login_repository_impl.dart';
import 'views/login_page.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => LoginRepositoryImpl()),
        Bind.singleton((i) => LoginBloc(i(), i())),
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute('/', child: (_, __) => const LoginPage())];
}

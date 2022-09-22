import 'package:flutter_modular/flutter_modular.dart';
import 'package:http_dio/providers/http_service_impl.dart';
import 'blocs/login_bloc.dart';
import 'repositories/login_repository_impl.dart';
import 'views/login_page.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => HttpServiceImpl()),
        Bind.factory((i) => LoginRepositoryImpl(i())),
        Bind.singleton((i) => LoginBloc(i())),
      ];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute('/', child: (_, __) => const LoginPage())];
}

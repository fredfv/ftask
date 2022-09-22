import 'package:auth/src/controllers/create_account_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http_dio/providers/http_service_impl.dart';
import 'blocs/login_bloc.dart';
import 'repositories/login_repository_impl.dart';
import 'views/create_account_page.dart';
import 'views/login_page.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => HttpServiceImpl()),
        Bind.factory((i) => LoginRepositoryImpl(i())),
        Bind.singleton((i) => LoginBloc(i())),
        Bind.singleton((i) => CreateAccountController(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const LoginPage(),),
        ChildRoute('/createaccount', child: (context, args) => const CreateAccountPage()),
  ];
}

import 'package:auth/src/controllers/create_account_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'controllers/login_controller.dart';
import 'views/create_account_page.dart';
import 'views/login_page.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory(
            (i) => LoginController(formsValidate: i(), loginRepository: i())),
        Bind.factory((i) =>
            CreateAccountController(loginRepository: i(), formsValidate: i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) =>
                LoginPage(controller: Modular.get<LoginController>())),
        ChildRoute(
          '/createaccount',
          child: (context, args) => CreateAccountPage(
              controller: Modular.get<CreateAccountController>()),
        ),
      ];
}

import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/modules/auth/controllers/create_account_controller.dart';
import 'package:task/src/modules/auth/controllers/login_controller.dart';
import 'package:task/src/modules/auth/use_cases/create_account_use_case_impl.dart';

import 'use_cases/login_use_case_impl.dart';
import 'views/create_account_page.dart';
import 'views/login_page.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => CreateAccountUseCaseImpl(
              httpService: i(),
              repositoryFactory: i(),
            )),
        Bind.lazySingleton((i) => LoginUseCaseImpl(
              httpService: i(),
              repositoryFactory: i(),
            )),
        Bind.factory((i) => LoginController(
              formsValidate: i(),
              repositoryFactory: i(),
              httpService: i(),
              loginUseCase: i(),
            )),
        Bind.factory((i) => CreateAccountController(
              repositoryFactory: i(),
              formsValidate: i(),
              httpService: i(),
              createAccountUseCase: i(),
            ))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => LoginPage(controller: Modular.get<LoginController>()),
            transition: TransitionType.rightToLeft),
        ChildRoute('/createaccount',
            child: (context, args) => CreateAccountPage(controller: Modular.get<CreateAccountController>()),
            transition: TransitionType.leftToRight),
      ];
}

import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/modules/home/controllers/create_task_controller.dart';
import 'package:task/src/modules/home/controllers/home_controller.dart';
import 'package:task/src/modules/home/controllers/list_task_controller.dart';
import 'package:task/src/modules/home/repositories/task_repository_impl.dart';

import 'views/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton(
            (i) => TaskRepositoryImpl(httpService: i(), objectIdService: i())),
        Bind.lazySingleton((i) => ListTaskController(taskRepository: i())),
        Bind.lazySingleton((i) =>
            CreateTaskController(taskRepository: i(), formsValidate: i())),
        Bind.lazySingleton((i) => HomeController(
            hub: i(), taskPageController: i(), listTaskController: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => HomePage(controller: Modular.get<HomeController>()),
        ),
      ];
}

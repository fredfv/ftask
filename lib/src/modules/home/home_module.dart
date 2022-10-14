import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/modules/home/controllers/create_task_controller.dart';
import 'package:task/src/modules/home/controllers/home_controller.dart';
import 'package:task/src/modules/home/controllers/list_task_controller.dart';
import 'package:task/src/modules/home/use_cases/update_tasks_from_cloud_usecase_impl.dart';

import 'views/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => UpdateTasksFromCloudUsecaseImpl(
              httpService: i(),
              repositoryFactory: i(),
            )),
        Bind.factory((i) => ListTaskController(
              httpService: i(),
              repositoryFactory: i(),
              hub: i(),
              updateTasksFromCloudUseCase: i(),
            )),
        Bind.factory((i) => CreateTaskController(
              taskRepository: i(),
              formsValidate: i(),
              hub: i(),
            )),
        Bind.factory((i) => HomeController(
              hub: i(),
              taskPageController: i(),
              listTaskController: i(),
            )),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => HomePage(controller: Modular.get<HomeController>()),
        ),
      ];
}

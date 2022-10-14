import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/core/infra/services/broadcast_controller.dart';
import 'package:task/src/core/infra/services/signalr_helper.dart';
import 'package:task/src/modules/home/presenter/create_task_page/create_task_controller.dart';
import 'package:task/src/modules/home/presenter/home_page/home_controller.dart';
import 'package:task/src/modules/home/presenter/list_task_page/list_task_controller.dart';
import 'package:task/src/modules/home/usecases/update_tasks_from_cloud_usecase_impl.dart';

import 'presenter/home_page/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => UpdateTasksFromCloudUsecase(
              httpService: i(),
              repositoryFactory: i(),
            )),
        Bind.factory((i) => ListTaskController(
              httpService: i(),
              repositoryFactory: i(),
              updateTasksFromCloudUseCase: i(),
              broadcastController: i(),
            )),
        Bind.factory((i) => CreateTaskController(
              taskRepository: i(),
              formsValidate: i(),
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

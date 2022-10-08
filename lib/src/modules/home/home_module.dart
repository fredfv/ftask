import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/modules/home/controllers/home_controller.dart';
import 'package:task/src/modules/home/views/list_task_page.dart';
import 'package:task/src/modules/home/views/task_page.dart';

import 'views/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => HomeController(hub: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (_, __) => HomePage(
                  controller: Modular.get<HomeController>(),
                ),
            children: [
              ChildRoute(
                '/task',
                child: (_, __) => const TaskPage(),
              ),
              ChildRoute(
                '/tasks',
                child: (_, __) => const ListTaskPage(id: ''),
              ),
            ]),
      ];
}

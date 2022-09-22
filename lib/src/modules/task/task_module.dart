import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/modules/task/controllers/task_controller.dart';
import 'package:task/src/modules/task/repositories/task_repository_impl.dart';
import 'package:task/src/modules/task/views/list_task_page.dart';
import 'package:task/src/modules/task/views/task_page.dart';

class TaskModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.factory((i) => TaskRepositoryImpl()),
    Bind.singleton((i) => TaskController(i()))
  ];

  @override
  List<ModularRoute> get routes => [
        //ROUTER OULET
        ChildRoute('/', child: (_, __) => TaskPage(), children: [
          // ChildRoute('/red', child: (_, __) => Container(color: Colors.red)),
          // ChildRoute('/blue', child: (_, __) => Container(color: Colors.blue)),
          // ChildRoute('/yellow', child: (_, __) => Container(color: Colors.yellow)),
        ]),
        //ChildRoute('/list/:id', child: (_, args) => ListTaskPage(id : args.params['id'] ?? ''))
        //ChildRoute('/list', child: (_, args) => ListTaskPage(id : args.queryParams['id'] ?? ''))
        ChildRoute('/list',
            child: (_, args) => ListTaskPage(id: args.data ?? ''),
            transition: TransitionType.fadeIn,
            duration: const Duration(milliseconds: 500))
      ];
}

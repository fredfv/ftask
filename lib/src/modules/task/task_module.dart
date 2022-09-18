import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/modules/task/views/list_task_page.dart';
import 'package:task/src/modules/task/views/task_page.dart';

class TaskModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const TaskPage()),
        //ChildRoute('/list/:id', child: (_, args) => ListTaskPage(id : args.params['id'] ?? ''))
        //ChildRoute('/list', child: (_, args) => ListTaskPage(id : args.queryParams['id'] ?? ''))
        ChildRoute('/list',
            child: (_, args) => ListTaskPage(id: args.data ?? ''),
            transition: TransitionType.fadeIn,
            duration: const Duration(milliseconds: 500))
      ];
}

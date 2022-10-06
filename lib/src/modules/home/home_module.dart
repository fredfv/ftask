import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/modules/home/controllers/home_controller.dart';

import '../../core/services/websocket/signalr_helper.dart';
import 'views/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => SignalRHelper()),
        Bind.factory((i) => HomeController(hub: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (_, __) =>
                HomePage(controller: Modular.get<HomeController>())),
      ];
}

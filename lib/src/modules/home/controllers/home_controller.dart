import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/core/infra/logger.dart';

import '../../../core/services/websocket/signalr_helper.dart';

class HomeController extends ChangeNotifier {
  int pageSelectedIndex = 0;

  final SignalRHelper hub;
  HomeController({required this.hub});

  changePage(int index) {
    fLog.i('$index - [TAB SELECTED]');
    pageSelectedIndex = index;

    if (index == 0) {
      Modular.to.navigate('/task');
    } else {
      Modular.to.navigate('./tasks');
    }

    notifyListeners();
  }
}

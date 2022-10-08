import 'package:flutter/cupertino.dart';

import '../../../core/services/websocket/signalr_helper.dart';
import '../views/chat_page.dart';
import '../views/list_task_page.dart';
import '../views/task_page.dart';

class HomeController extends ChangeNotifier {
  int pageSelectedIndex = 0;

  final SignalRHelper hub;
  final PageController pageController = PageController(initialPage: 0, keepPage: true);
  final List<Widget> pages = const [TaskPage(), ListTaskPage(), ChatPage()];

  HomeController({required this.hub});

  changePage(int index) {
    pageController.jumpToPage(index);
    pageSelectedIndex = index;
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';

import '../../../core/services/websocket/signalr_helper.dart';
import '../views/chat_page.dart';
import '../views/list_task_page.dart';
import '../views/task_page.dart';
import 'create_task_controller.dart';
import 'list_task_controller.dart';

class HomeController extends ChangeNotifier {
  int pageSelectedIndex = 0;
  final CreateTaskController taskPageController;
  final ListTaskController listTaskController;

  final SignalRHelper hub;
  final PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  final List<Widget> pages;

  HomeController({
    required this.hub,
    required this.taskPageController,
    required this.listTaskController,
  }) : pages = [
          TaskPage(controller: taskPageController),
          ListTaskPage(controller: listTaskController),
          const ChatPage(),
        ];

  changePage(int index) {
    pageController.jumpToPage(index);
    pageSelectedIndex = index;

    if (index == 1) {
      listTaskController.listAll();
    }

    notifyListeners();
  }
}

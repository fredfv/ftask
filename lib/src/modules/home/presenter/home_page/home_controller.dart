import 'package:flutter/cupertino.dart';

import '../../../../core/infra/services/signalr_helper.dart';
import '../chat_page/chat_page.dart';
import '../create_task_page/create_task_controller.dart';
import '../create_task_page/create_task_page.dart';
import '../list_task_page/list_task_controller.dart';
import '../list_task_page/list_task_page.dart';

class HomeController extends ChangeNotifier {
  int pageSelectedIndex = 0;
  final CreateTaskController taskPageController;
  final ListTaskController listTaskController;

  final SignalRHelper hub;
  final PageController pageController = PageController(initialPage: 0, keepPage: true);
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

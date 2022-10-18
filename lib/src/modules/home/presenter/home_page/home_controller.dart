import 'package:flutter/cupertino.dart';
import 'package:task/src/core/domain/usecases/i_upload_tasks_to_cloud_usecase.dart';

import '../../../../core/domain/entities/task_entity.dart';
import '../../../../core/domain/usecases/i_put_task_from_broadcast_usecase.dart';
import '../../../../core/domain/usecases/i_set_on_board_status_usecase.dart';
import '../../../../core/domain/usecases/i_update_tasks_from_cloud_usecase.dart';
import '../../../../core/infra/services/broadcast_controller.dart';
import '../../../../core/infra/services/signalr_helper.dart';
import '../create_task_page/create_task_controller.dart';
import '../create_task_page/create_task_page.dart';
import '../list_task_done_page/list_task_done_controller.dart';
import '../list_task_done_page/list_task_done_page.dart';
import '../list_task_page/list_task_controller.dart';
import '../list_task_page/list_task_page.dart';

class HomeController extends ChangeNotifier {
  int pageSelectedIndex = 0;
  final CreateTaskController taskPageController;
  final ListTaskController listTaskController;
  final ListTaskDoneController listTaskDoneController;
  final IUpdateTasksFromCloudUsecase updateTasksFromCloudUsecase;
  final IPutTaskFromBroadcastUsecase putTaskFromBroadcastUsecase;
  final IUploadTasksToCloudUsecase uploadTasksToCloudUsecase;
  final BroadcastController broadcastController;

  final SignalRHelper hub;
  final PageController pageController = PageController(initialPage: 0, keepPage: true);
  final List<Widget> pages;

  HomeController({
    required this.hub,
    required this.taskPageController,
    required this.listTaskController,
    required this.listTaskDoneController,
    required this.updateTasksFromCloudUsecase,
    required this.putTaskFromBroadcastUsecase,
    required this.uploadTasksToCloudUsecase,
    required this.broadcastController,
  }) : pages = [
          TaskPage(controller: taskPageController),
          ListTaskPage(controller: listTaskController),
          ListTaskDonePage(controller: listTaskDoneController),
        ] {
    callGetAllTasksControllersFromLocal();
    uploadAndGetAllFromCloudExecute();
    broadcastController.getAllTasksBroadcastValueNotifier.addListener(() async {
      callGetAllTasksControllersFromLocal();
    });
    broadcastController.putTaskBroadcastValueNotifier.addListener(() async {
      TaskEntity taskEntity = TaskEntity.fromCloud(broadcastController.putTaskBroadcastValueNotifier.value.entity);
      await putTaskFromBroadcastUsecase(taskEntity);
      // listTaskController.addTaskToListFromBroadcast(taskEntity);
      // listTaskDoneController.addTaskToListFromBroadcast(taskEntity);
      await callGetAllTasksControllersFromLocal();
    });
  }

  callGetAllTasksControllersFromLocal() async {
    await updateTasksFromCloudUsecase();
    listTaskController.getAllTasksFromLocal();
    listTaskDoneController.getAllTasksFromLocal();
    notifyListeners();
  }

  uploadAndGetAllFromCloudExecute() async {
    await uploadTasksToCloudUsecase();
    await updateTasksFromCloudUsecase();
  }

  changePage(int index) {
    pageController.jumpToPage(index);
    pageSelectedIndex = index;
    notifyListeners();
  }
}

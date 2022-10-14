import 'package:flutter/cupertino.dart';
import 'package:task/src/core/application/common_state.dart';
import 'package:task/src/core/domain/repositories/repository_factory.dart';
import 'package:task/src/core/services/http_service.dart';
import 'package:task/src/core/services/websocket/signalr_helper.dart';

import '../../../core/domain/task_entity.dart';
import '../../../core/domain/use_cases/update_tasks_from_cloud_use_case.dart';

class ListTaskController extends ValueNotifier<CommonState> {
  final HttpService httpService;
  final RepositoryFactory repositoryFactory;
  final SignalRHelper hub;
  final List<TaskEntity> list = [];
  final UpdateTasksFromCloudUseCase updateTasksFromCloudUseCase;

  ListTaskController({
    required this.httpService,
    required this.repositoryFactory,
    required this.hub,
    required this.updateTasksFromCloudUseCase,
  }) : super(IdleState()) {
    hub.stream.listen((event) async {
      await updateTasksFromCloudUseCase();
      listAll();
    });
  }

  void listAll() {
    value = LoadingState();
    repositoryFactory.get<TaskEntity>().then((taskRepository) async {
      taskRepository.getAll().then((v) {
        if (v is Exception) {
          value = ErrorState(v.toString());
        } else {
          value = SuccessState();
          list.clear();
          list.addAll(v);
          notifyListeners();
        }
      });
    });
  }
}

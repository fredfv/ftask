import 'package:flutter/cupertino.dart';
import 'package:task/src/core/infra/application/broadcast_message.dart';
import 'package:task/src/core/infra/services/broadcast_controller.dart';

import '../../../../core/domain/entities/task_entity.dart';
import '../../../../core/domain/repositories/repository_factory.dart';
import '../../../../core/domain/services/http_service.dart';
import '../../../../core/domain/usecases/update_tasks_from_cloud_usecase.dart';
import '../../../../core/infra/application/common_state.dart';

class ListTaskController extends ValueNotifier<CommonState> {
  final HttpService httpService;
  final RepositoryFactory repositoryFactory;
  final List<TaskEntity> list = [];
  final UpdateTasksFromCloudUsecase updateTasksFromCloudUseCase;
  final BroadcastController broadcastController;

  ListTaskController(
      {required this.httpService,
      required this.repositoryFactory,
      required this.updateTasksFromCloudUseCase,
      required this.broadcastController})
      : super(IdleState()) {
    broadcastController.getAllTasksBroadcastValueNotifier.addListener(() async {
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

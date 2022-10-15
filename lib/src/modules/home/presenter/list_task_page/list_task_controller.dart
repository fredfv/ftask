import 'package:flutter/cupertino.dart';
import 'package:task/src/core/infra/services/broadcast_controller.dart';
import 'package:task/src/modules/home/models/task_tile_model.dart';

import '../../../../core/domain/entities/task_entity.dart';
import '../../../../core/domain/repositories/i_repository_factory.dart';
import '../../../../core/domain/services/i_http_service.dart';
import '../../../../core/domain/usecases/i_update_tasks_from_cloud_usecase.dart';
import '../../../../core/infra/application/common_state.dart';

class ListTaskController extends ValueNotifier<CommonState> {
  final IHttpService httpService;
  final IRepositoryFactory repositoryFactory;
  final List<TaskTileModel> list = [];
  final IUpdateTasksFromCloudUsecase updateTasksFromCloudUseCase;
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
          list.addAll(v.map((e) => TaskTileModel.fromEntity(e)));
          notifyListeners();
        }
      });
    });
  }
}

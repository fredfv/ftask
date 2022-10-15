import 'package:flutter/cupertino.dart';
import 'package:task/src/core/infra/services/broadcast_controller.dart';
import 'package:task/src/modules/home/models/task_tile_model.dart';

import '../../../../core/domain/entities/task_entity.dart';
import '../../../../core/domain/repositories/i_repository_factory.dart';
import '../../../../core/infra/application/common_state.dart';

class ListTaskDoneController extends ValueNotifier<CommonState> {
  final IRepositoryFactory repositoryFactory;
  final List<TaskTileModel> list = [];
  final BroadcastController broadcastController;

  ListTaskDoneController({
    required this.repositoryFactory,
    required this.broadcastController,
  }) : super(IdleState()) {
    getAllTasksFromLocal();
    broadcastController.getAllTasksBroadcastValueNotifier.addListener(() async {
      getAllTasksFromLocal();
    });
    broadcastController.putTaskBroadcastValueNotifier.addListener(() async {
      addTaskToListFromBroadcast(broadcastController.putTaskBroadcastValueNotifier.value.entity);
    });
  }

  void addTaskToListFromBroadcast(Map entity) {
    value = LoadingState();
    TaskEntity taskEntity = TaskEntity.fromCloud(entity);
    if (taskEntity.deleted == null) {
      list.add(TaskTileModel.fromEntity(taskEntity));
    } else {
      list.removeWhere((element) => element.id == taskEntity.id);
    }
    value = SuccessState();
  }

  void getAllTasksFromLocal() {
    value = LoadingState();
    repositoryFactory.get<TaskEntity>().then((taskRepository) async {
      taskRepository.query(false).then((v) {
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

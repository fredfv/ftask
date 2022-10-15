import 'package:flutter/cupertino.dart';
import 'package:task/src/core/domain/usecases/i_get_by_id_from_cloud_usecase.dart';
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
  final IUpdateTasksFromCloudUsecase updateTasksFromCloudUsecase;
  final IGetByIdFromCloudUsecase getByIdFromCloudUsecase;
  final BroadcastController broadcastController;

  ListTaskController({
    required this.httpService,
    required this.repositoryFactory,
    required this.updateTasksFromCloudUsecase,
    required this.broadcastController,
    required this.getByIdFromCloudUsecase,
  }) : super(IdleState()) {
    updateTasksFromCloudExecute();
    broadcastController.getAllTasksBroadcastValueNotifier.addListener(() async {
      updateTasksFromCloudExecute();
    });
    broadcastController.putTaskBroadcastValueNotifier.addListener(() async {
      putTaskBroadcastExecute(broadcastController.putTaskBroadcastValueNotifier.value.entity);
    });
    broadcastController.getByIdBroadcastMessage.addListener(() async {
      getByIdFromCloudExecute(broadcastController.getByIdBroadcastMessage.value.id);
    });
  }

  void updateTasksFromCloudExecute() async {
    await updateTasksFromCloudUsecase();
    getAllTasksBroadcastExecute();
  }

  void getAllTasksBroadcastExecute() {
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

  void putTaskBroadcastExecute(Map entity) {
    value = LoadingState();
    TaskEntity taskEntity = TaskEntity.fromCloud(entity);
    list.add(TaskTileModel.fromEntity(taskEntity));
    value = SuccessState();
  }

  void getByIdFromCloudExecute(String id) async {
    await getByIdFromCloudUsecase(id);
    getByIdBroadcastMessage(id);
  }

  void getByIdBroadcastMessage(String id) {
    value = LoadingState();
    repositoryFactory.get<TaskEntity>().then((taskRepository) async {
      taskRepository.get(id).then((v) {
        if (v is Exception || v == null) {
          value = ErrorState(v.toString());
        } else {
          value = SuccessState();
          if (v.deleted == null) {
            list.add(TaskTileModel.fromEntity(v));
          } else {
            list.removeWhere((element) => element.id == v.id);
          }
          notifyListeners();
        }
      });
    });
  }
}

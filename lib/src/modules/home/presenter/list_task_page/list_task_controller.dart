import 'dart:async';

import 'package:flutter/cupertino.dart';
import '../../../../core/domain/entities/task_entity.dart';
import '../../../../core/domain/repositories/i_repository_factory.dart';
import '../../../../core/infra/application/common_state.dart';
import '../../models/task_tile_model.dart';

class ListTaskController extends ValueNotifier<CommonState> {
  final IRepositoryFactory repositoryFactory;
  final List<TaskTileModel> list = [];
  final ChangeNotifier timeElapsedChangeNotifier = ChangeNotifier();
  Timer? timer;

  ListTaskController({
    required this.repositoryFactory,
  }) : super(IdleState());

  void updateTilesTimeElapsed() {
    for (var element in list) {
      element.updateTimeElapsed();
    }
  }

  void addTaskToListFromBroadcast(TaskEntity taskEntity) {
    value = LoadingState();
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
      taskRepository.query(true).then((v) {
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
  // void getByIdFromCloudExecute(String id) async {
  //   await getByIdFromCloudUsecase(id);
  //   getByIdBroadcastMessage(id);
  // }
  //
  // void getByIdBroadcastMessage(String id) {
  //   value = LoadingState();
  //   repositoryFactory.get<TaskEntity>().then((taskRepository) async {
  //     taskRepository.get(id).then((v) {
  //       if (v is Exception || v == null) {
  //         value = ErrorState(v.toString());
  //       } else {
  //         value = SuccessState();
  //         if (v.deleted == null) {
  //           list.add(TaskTileModel.fromEntity(v));
  //         } else {
  //           list.removeWhere((element) => element.id == v.id);
  //         }
  //         notifyListeners();
  //       }
  //     });
  //   });
  // }
}

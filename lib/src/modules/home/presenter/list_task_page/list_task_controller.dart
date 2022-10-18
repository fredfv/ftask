import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:task/src/core/domain/usecases/i_set_on_board_status_usecase.dart';
import '../../../../core/domain/entities/task_entity.dart';
import '../../../../core/domain/repositories/i_repository_factory.dart';
import '../../../../core/infra/application/common_state.dart';
import '../../models/task_tile_model.dart';

class ListTaskController extends ValueNotifier<CommonState> {
  final IRepositoryFactory repositoryFactory;
  final List<TaskTileModel> list = [];
  final ChangeNotifier timeElapsedChangeNotifier = ChangeNotifier();
  final ISetOnBoardStatusUsecase setOnBoardStatusUsecase;
  Timer? timer;

  ListTaskController({
    required this.repositoryFactory,
    required this.setOnBoardStatusUsecase,
  }) : super(IdleState()) {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateTilesTimeElapsed();
      timeElapsedChangeNotifier.notifyListeners();
    });
  }

  void updateTilesTimeElapsed() {
    for (var element in list) {
      element.refresh();
    }
  }

  void setOnBoardStatusUsecaseExecute(String id) async {
    setOnBoardStatusUsecase(id, false).then((_) {
      getAllTasksFromLocal();
    }).onError((error, stackTrace) {
      value = ErrorState(error.toString());
    });
  }

  void addTaskToListFromBroadcast(TaskEntity taskEntity) {
    getAllTasksFromLocal();
  }

  void getAllTasksFromLocal() {
    value = LoadingState();
    repositoryFactory.get<TaskEntity>().then((taskRepository) async {
      taskRepository.getWhere((t) => t.onBoard == true).then((v) {
        if (v is Exception) {
          value = ErrorState(v.toString());
        } else {
          list.clear();
          list.addAll(v.map((e) => TaskTileModel.fromEntity(e)));
          value = SuccessState();
        }
      });
    }).onError((error, stackTrace) {
      value = ErrorState(error.toString());
    });
  }
}

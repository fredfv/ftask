import 'package:flutter/cupertino.dart';
import '../../../../core/domain/entities/task_entity.dart';
import '../../../../core/domain/repositories/i_repository_factory.dart';
import '../../../../core/domain/usecases/i_set_on_board_status_usecase.dart';
import '../../../../core/infra/application/common_state.dart';
import '../../models/task_tile_model.dart';

class ListTaskDoneController extends ValueNotifier<CommonState> {
  final IRepositoryFactory repositoryFactory;
  final List<TaskTileModel> list = [];
  final ISetOnBoardStatusUsecase setOnBoardStatusUsecase;

  ListTaskDoneController({
    required this.repositoryFactory,
    required this.setOnBoardStatusUsecase,
  }) : super(IdleState());

  void setOnBoardStatusUsecaseExecute(String id) async {
    await setOnBoardStatusUsecase(id, true);
  }

  void addTaskToListFromBroadcast(TaskEntity taskEntity) {
    value = LoadingState();
    if (taskEntity.deleted == null && taskEntity.onBoard == false) {
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
          list.clear();
          list.addAll(v.map((e) => TaskTileModel.fromEntity(e)));
          value = SuccessState();
        }
      });
    });
  }
}

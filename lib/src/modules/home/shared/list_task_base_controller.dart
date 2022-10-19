import 'package:flutter/cupertino.dart';

import '../../../core/domain/entities/task_entity.dart';
import '../../../core/domain/repositories/i_repository_factory.dart';
import '../../../core/domain/usecases/i_download_tasks_from_cloud_usecase.dart';
import '../../../core/domain/usecases/i_set_on_board_status_usecase.dart';
import '../../../core/domain/usecases/i_upload_tasks_to_cloud_usecase.dart';
import '../../../core/infra/application/common_state.dart';
import '../models/task_tile_model.dart';

class ListTaskBaseController extends ValueNotifier<CommonState> {
  final IRepositoryFactory repositoryFactory;
  final List<TaskTileModel> list = [];
  final ISetOnBoardStatusUsecase setOnBoardStatusUsecase;
  final IUploadTasksToCloudUsecase uploadTasksToCloudUsecase;
  final IDownloadTasksFromCloudUsecase downloadTasksFromCloudUsecase;

  ListTaskBaseController({
    required this.repositoryFactory,
    required this.setOnBoardStatusUsecase,
    required this.uploadTasksToCloudUsecase,
    required this.downloadTasksFromCloudUsecase,
  }) : super(IdleState());

  void setOnBoardStatusUsecaseExecute({required String taskId, required bool onBoard}) async {
    setOnBoardStatusUsecase(taskId, onBoard).then((_) {
      getAllTasksFromLocal(onBoard: onBoard);
    }).onError((error, stackTrace) {
      value = ErrorState(error.toString());
    });
  }

  void addTaskToListFromBroadcast({required bool onBoard}) {
    getAllTasksFromLocal(onBoard: onBoard);
  }

  void getAllTasksFromLocal({required bool onBoard}) {
    value = LoadingState();
    repositoryFactory.get<TaskEntity>().then((taskRepository) async {
      taskRepository.getWhere((t) => t.onBoard == onBoard).then((v) {
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

  Future<void> uploadAndGetAllFromCloudExecute({required bool onBoard}) async {
    await uploadTasksToCloudUsecase();
    await downloadTasksFromCloudUsecase();
    getAllTasksFromLocal(onBoard: onBoard);
  }
}

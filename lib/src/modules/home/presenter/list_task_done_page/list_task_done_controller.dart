import 'dart:async';

import 'package:flutter/material.dart';
import '../../../../core/domain/repositories/i_repository_factory.dart';
import '../../../../core/domain/usecases/i_download_tasks_from_cloud_usecase.dart';
import '../../../../core/domain/usecases/i_set_on_board_status_usecase.dart';
import '../../../../core/domain/usecases/i_upload_tasks_to_cloud_usecase.dart';
import '../../shared/list_task_base_controller.dart';

class ListTaskDoneController extends ListTaskBaseController {
  final ChangeNotifier timeElapsedChangeNotifier = ChangeNotifier();
  Timer? timer;

  ListTaskDoneController({
    required IRepositoryFactory repositoryFactory,
    required ISetOnBoardStatusUsecase setOnBoardStatusUsecase,
    required IUploadTasksToCloudUsecase uploadTasksToCloudUsecase,
    required IDownloadTasksFromCloudUsecase downloadTasksFromCloudUsecase,
  }) : super(
          repositoryFactory: repositoryFactory,
          setOnBoardStatusUsecase: setOnBoardStatusUsecase,
          uploadTasksToCloudUsecase: uploadTasksToCloudUsecase,
          downloadTasksFromCloudUsecase: downloadTasksFromCloudUsecase,
        );
}

// import 'package:flutter/cupertino.dart';
// import '../../../../core/domain/entities/task_entity.dart';
// import '../../../../core/domain/repositories/i_repository_factory.dart';
// import '../../../../core/domain/usecases/i_set_on_board_status_usecase.dart';
// import '../../../../core/infra/application/common_state.dart';
// import '../../models/task_tile_model.dart';
//
// class ListTaskDoneController extends ValueNotifier<CommonState> {
//   final IRepositoryFactory repositoryFactory;
//   final List<TaskTileModel> list = [];
//   final ISetOnBoardStatusUsecase setOnBoardStatusUsecase;
//
//   ListTaskDoneController({
//     required this.repositoryFactory,
//     required this.setOnBoardStatusUsecase,
//   }) : super(IdleState());
//
//   void setOnBoardStatusUsecaseExecute(String id) async {
//     await setOnBoardStatusUsecase(id, true).then((_) {
//       list.removeWhere((element) => element.id == id);
//       notifyListeners();
//     }).onError((error, stackTrace) {
//       value = ErrorState(error.toString());
//     });
//   }
//
//   void addTaskToListFromBroadcast(TaskEntity taskEntity) {
//     value = LoadingState();
//     if (taskEntity.deleted == null && taskEntity.onBoard == false) {
//       list.add(TaskTileModel.fromEntity(taskEntity));
//     } else {
//       list.removeWhere((element) => element.id == taskEntity.id);
//     }
//     value = SuccessState();
//   }
//
//   void getAllTasksFromLocal() {
//     value = LoadingState();
//     repositoryFactory.get<TaskEntity>().then((taskRepository) async {
//       taskRepository.getWhere((t) => t.onBoard == false).then((v) {
//         if (v is Exception) {
//           value = ErrorState(v.toString());
//         } else {
//           list.clear();
//           list.addAll(v.map((e) => TaskTileModel.fromEntity(e)));
//           value = SuccessState();
//         }
//       });
//     });
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:task/src/core/application/common_state.dart';

import '../../../core/domain/task_entity.dart';
import '../repositories/task_repository_impl.dart';

class ListTaskController extends ValueNotifier<CommonState> {
  final TaskRepositoryImpl taskRepository;
  final List<TaskEntity> list = [];

  ListTaskController({
    required this.taskRepository,
  }) : super(IdleState());

  void listAll() {
    value = LoadingState();
    taskRepository.getAll().then((v) {
      if (v is Exception) {
        value = ErrorState(v.toString());
      } else {
        value = SuccessState();
        list.clear();
        list.addAll(v);
      }
    });
  }
}

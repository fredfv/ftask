import 'package:flutter/cupertino.dart';
import 'package:task/src/core/application/common_state.dart';
import 'package:task/src/core/domain/task_entity.dart';

import '../../../core/services/form_validate_service.dart';
import '../repositories/task_repository_impl.dart';

class CreateTaskController extends ValueNotifier<CommonState> {
  final TaskRepositoryImpl taskRepository;
  final FormsValidateService formsValidate;
  FocusNode descriptionFocus = FocusNode();
  FocusNode dueDateFocus = FocusNode();
  FocusNode secretConfirmFocus = FocusNode();

  CreateTaskController({
    required this.taskRepository,
    required this.formsValidate,
  }) : super(IdleState());

  TaskEntity newTask = TaskEntity.empty();

  GlobalKey<FormState> get form => formsValidate.form;

  void setDescriptionFocus(value) {
    descriptionFocus.requestFocus();
  }

  void setDueDateFocus(value) {
    dueDateFocus.requestFocus();
  }

  void executeAddNewTask(BuildContext context) {
    if (formsValidate.validate()) {
      value = LoadingState();
      taskRepository.put(null, newTask).then((v) {
        if (v is Exception) {
          value = ErrorState(v.toString());
        } else {
          value = SuccessState<String>(response: 'new task added');
        }
        newTask = TaskEntity.empty();
      }).onError((error, stackTrace) {
        value = ErrorState(error.toString());
      });
    } else {
      value = ErrorState('invalid fields');
    }
  }
}

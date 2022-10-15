import 'package:flutter/material.dart';

import '../../../../core/domain/entities/task_entity.dart';
import '../../../../core/domain/repositories/i_repository_factory.dart';
import '../../../../core/domain/services/i_form_validate_service.dart';
import '../../../../core/infra/application/common_state.dart';
import '../../../../core/infra/application/logger.dart';
import '../../../../core/infra/services/signalr_helper.dart';

class CreateTaskController extends ValueNotifier<CommonState> {
  final IRepositoryFactory taskRepository;
  final IFormsValidateService formsValidate;
  FocusNode descriptionFocus = FocusNode();
  FocusNode dueDateFocus = FocusNode();
  FocusNode secretConfirmFocus = FocusNode();

  TextEditingController titleController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  CreateTaskController({
    required this.taskRepository,
    required this.formsValidate,
  }) : super(IdleState());

  GlobalKey<FormState> get form => formsValidate.form;

  void setDescriptionFocus(value) {
    descriptionFocus.requestFocus();
  }

  void setDueDateFocus(value) {
    dueDateFocus.requestFocus();
  }

  void executeAddNewTask() {
    if (formsValidate.validate()) {
      TaskEntity newTask = TaskEntity(
        title: titleController.text,
        description: descriptionController.text,
        dueDate: dueDateController.text,
        id: '',
        created: DateTime.fromMillisecondsSinceEpoch(0),
        persisted: DateTime.fromMillisecondsSinceEpoch(0),
        onBoard: false,
      );
      value = LoadingState();
      taskRepository.get<TaskEntity>().then((hiveRepository) async {
        hiveRepository.put(null, newTask).then((v) {
          if (v is Exception) {
            value = ErrorState(v.toString());
          } else {
            titleController.clear();
            descriptionController.clear();
            dueDateController.clear();
            formsValidate.form.currentState?.reset();
            value = SuccessState<String>(response: 'new task added');
          }
        });
      }).onError((error, stackTrace) {
        value = ErrorState(error.toString());
      });
    } else {
      value = ErrorState('invalid fields');
    }
  }
}

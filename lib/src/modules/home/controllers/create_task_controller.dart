import 'package:flutter/cupertino.dart';
import 'package:task/src/core/application/common_state.dart';
import 'package:task/src/core/domain/repositories/repository_factory.dart';
import 'package:task/src/core/domain/task_entity.dart';
import 'package:task/src/core/services/websocket/signalr_helper.dart';

import '../../../core/services/form_validate_service.dart';
import '../repositories/task_repository_impl.dart';

class CreateTaskController extends ValueNotifier<CommonState> {
  final RepositoryFactory taskRepository;
  final FormsValidateService formsValidate;
  FocusNode descriptionFocus = FocusNode();
  FocusNode dueDateFocus = FocusNode();
  FocusNode secretConfirmFocus = FocusNode();
  SignalRHelper hub;

  TextEditingController titleController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  CreateTaskController({
    required this.taskRepository,
    required this.formsValidate,
    required this.hub,
  }) : super(IdleState()) {
    hub.stream.listen((event) {
      print(event.toString() + 'Escutei da create');
    });
  }

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

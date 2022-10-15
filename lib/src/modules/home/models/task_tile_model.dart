import 'package:intl/intl.dart';
import 'package:task/src/modules/home/models/task_due_state.dart';
import 'package:task/src/modules/home/models/task_due_time.dart';

import '../../../core/domain/entities/task_entity.dart';

class TaskTileModel {
  final String title;
  final String description;
  final String dueDate;
  final TaskDueState dueState;
  final String timeElapsed;

  TaskTileModel({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.dueState,
    required this.timeElapsed,
  });

  factory TaskTileModel.fromEntity(TaskEntity entity) {
    final dueDate = entity.dueDate;
    final dueDateParsed = DateTime.tryParse(dueDate);
    final now = DateTime.now().toUtc();
    Duration? timeElapsed;
    if (dueDateParsed != null) {
      timeElapsed = now.difference(dueDateParsed);
    }
    final dueState = timeElapsed == null
        ? TaskDueState.error
        : timeElapsed.inSeconds > TaskDueTime.late && timeElapsed.inSeconds < TaskDueTime.veryLate
            ? TaskDueState.late
            : timeElapsed.inSeconds > TaskDueTime.veryLate
                ? TaskDueState.veryLate
                : TaskDueState.ontime;

    return TaskTileModel(
      title: entity.title,
      description: entity.description,
      dueDate: dueDate,
      dueState: dueState,
      timeElapsed: timeElapsed == null ? '' : timeElapsed.toString().substring(0, 7),
    );
  }
}

import 'package:task/src/modules/home/models/task_due_state.dart';
import 'package:task/src/modules/home/models/task_due_time.dart';

import '../../../core/domain/entities/task_entity.dart';

class TaskTileModel {
  final String id;
  final String title;
  final String description;
  final String dueDate;
  final DateTime? updated;
  final bool onBoard;
  TaskDueState dueState;
  String timeElapsed;

  TaskTileModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.updated,
    required this.dueState,
    required this.timeElapsed,
    required this.onBoard,
  });

  updateTimeElapsed() {
    final dueDateParsed = DateTime.tryParse(dueDate);
    final now = DateTime.now();
    Duration? timeElapsed;
    if (dueDateParsed != null) {
      timeElapsed = now.difference(dueDateParsed);
    }

    dueState = timeElapsed == null
        ? TaskDueState.error
        : timeElapsed.inSeconds > TaskDueTime.late && timeElapsed.inSeconds < TaskDueTime.veryLate
            ? TaskDueState.late
            : timeElapsed.inSeconds > TaskDueTime.veryLate
                ? TaskDueState.veryLate
                : TaskDueState.ontime;

    timeElapsed = timeElapsed == null
        ? null
        : timeElapsed.inSeconds < 0
            ? timeElapsed * -1
            : timeElapsed;

    this.timeElapsed = timeElapsed == null ? '' : timeElapsed.toString().substring(0, 7);
  }

  factory TaskTileModel.fromEntity(TaskEntity entity) {
    final dueDate = entity.dueDate;
    final dueDateParsed = DateTime.tryParse(dueDate);
    final now = DateTime.now();
    Duration? timeElapsed;
    if (dueDateParsed != null) {
      if (entity.onBoard) {
        timeElapsed = now.difference(dueDateParsed);
      } else {
        timeElapsed = entity.updated?.difference(dueDateParsed);
      }
    }

    final dueState = timeElapsed == null
        ? TaskDueState.error
        : timeElapsed.inSeconds > TaskDueTime.late && timeElapsed.inSeconds <= TaskDueTime.veryLate
            ? TaskDueState.late
            : timeElapsed.inSeconds > TaskDueTime.veryLate
                ? TaskDueState.veryLate
                : TaskDueState.ontime;

    timeElapsed = timeElapsed == null
        ? null
        : timeElapsed.inSeconds < 0
            ? timeElapsed * -1
            : timeElapsed;

    return TaskTileModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      dueDate: dueDate,
      dueState: dueState,
      updated: entity.updated,
      onBoard: entity.onBoard,
      timeElapsed: timeElapsed == null ? '' : timeElapsed.toString().substring(0, 7),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task/src/modules/home/models/task_due_state.dart';

abstract class TaskDueStateColorConverter {
  static Color get(TaskDueState state) {
    switch (state) {
      case TaskDueState.ontime:
        return Colors.transparent;
      case TaskDueState.late:
        return Colors.yellow;
      case TaskDueState.veryLate:
        return Colors.red;
      case TaskDueState.error:
        return Colors.black;
      default:
        return Colors.transparent;
    }
  }
}

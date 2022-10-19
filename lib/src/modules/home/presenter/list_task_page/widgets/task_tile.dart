import 'package:flutter/material.dart';
import 'package:task/src/modules/home/models/task_tile_model.dart';
import 'package:task/src/modules/home/shared/widgets/row_due_date.dart';
import 'package:task/src/modules/home/shared/widgets/row_time_animated.dart';

import '../../../../../core/presenter/shared/common_spacing.dart';
import '../../../../../core/presenter/theme/spacing_type.dart';
import '../../../shared/widgets/button_card_task.dart';
import '../../../shared/widgets/row_title.dart';

class TaskTile extends StatelessWidget {
  final TaskTileModel taskItem;
  final ChangeNotifier controller;
  final VoidCallback onLongPress;

  const TaskTile({
    Key? key,
    required this.taskItem,
    required this.onLongPress,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonCardTask(
      onLongPress: onLongPress,
      children: [
        const CommonSpacing(SpacingType.height),
        RowTitle(taskItem: taskItem),
        const CommonSpacing(SpacingType.height),
        RowDueDate(text: taskItem.dueDateString),
        const CommonSpacing(SpacingType.height),
        RowTimeAnimated(taskItem: taskItem, controller: controller),
        const CommonSpacing(SpacingType.height),
        if (taskItem.errorMessage != null)
          Text(
            taskItem.errorMessage ?? '',
            style: const TextStyle(color: Colors.orange),
          ),
      ],
    );
  }
}

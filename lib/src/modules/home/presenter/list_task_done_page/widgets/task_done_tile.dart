import 'package:flutter/material.dart';
import 'package:task/src/modules/home/models/task_tile_model.dart';

import '../../../../../core/presenter/shared/common_spacing.dart';
import '../../../../../core/presenter/theme/spacing_type.dart';
import '../../../shared/widgets/button_card_task.dart';
import '../../../shared/widgets/row_due_date.dart';
import '../../../shared/widgets/row_time.dart';
import '../../../shared/widgets/row_title.dart';

class TaskDoneTile extends StatelessWidget {
  final TaskTileModel taskItem;
  final VoidCallback onLongPress;

  const TaskDoneTile({
    Key? key,
    required this.taskItem,
    required this.onLongPress,
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
        RowTime(text: taskItem.timeElapsed, dueState: taskItem.dueState),
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

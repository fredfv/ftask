import 'package:flutter/material.dart';
import 'package:task/src/core/presenter/theme/responsive_outlet.dart';
import 'package:task/src/modules/home/models/task_tile_model.dart';
import 'package:task/src/modules/home/shared/widgets/row_due_date.dart';
import 'package:task/src/modules/home/shared/widgets/row_time_animated.dart';
import 'package:task/src/modules/home/shared/widgets/text_task_request_error.dart';

import '../../../../../core/presenter/shared/common_spacing.dart';
import '../../../../../core/presenter/theme/size_outlet.dart';
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
        RowTitle(taskItem: taskItem),
        CommonSpacing.height(factor: SizeOutlet.spacingFactor),
        RowDueDate(text: taskItem.dueDateString),
        CommonSpacing.height(factor: SizeOutlet.spacingFactor),
        RowTimeAnimated(taskItem: taskItem, controller: controller),
        CommonSpacing.height(factor: SizeOutlet.spacingFactor),
        TextTaskRequestError(taskItem: taskItem)
      ],
    );
  }
}

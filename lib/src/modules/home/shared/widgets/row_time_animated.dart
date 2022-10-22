import 'package:flutter/material.dart';
import 'package:task/src/core/presenter/theme/size_outlet.dart';

import '../../../../core/presenter/shared/common_spacing.dart';
import '../../../../core/presenter/shared/common_text.dart';
import '../../../../core/presenter/theme/responsive_outlet.dart';
import '../../models/task_tile_model.dart';
import '../task_due_state_color_converter.dart';

class RowTimeAnimated extends StatelessWidget {
  final TaskTileModel taskItem;
  final ChangeNotifier controller;

  const RowTimeAnimated({
    Key? key,
    required this.taskItem,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedBuilder(
          animation: controller,
          builder: (_, child) {
            return Row(
              children: [
                Icon(
                  Icons.timer_sharp,
                  color: TaskDueStateColorConverter.convert(taskItem.dueState),
                ),
                CommonSpacing.width(factor: SizeOutlet.spacingFactor3),
                CommonText(
                  fontColor: TaskDueStateColorConverter.convert(taskItem.dueState),
                  fontSize: ResponsiveOutlet.textMedium(context),
                  text: taskItem.timeElapsed,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

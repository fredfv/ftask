import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:task/src/core/presenter/shared/common_loading.dart';
import 'package:task/src/modules/home/models/task_tile_model.dart';
import 'package:task/src/modules/home/shared/task_due_state_color_converter.dart';

import '../../../../../core/presenter/shared/common_spacing.dart';
import '../../../../../core/presenter/shared/common_text.dart';
import '../../../../../core/presenter/theme/color_outlet.dart';
import '../../../../../core/presenter/theme/size_outlet.dart';
import '../../../../../core/presenter/theme/spacing_type.dart';
import '../list_task_controller.dart';

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
    return InkWell(
      onLongPress: onLongPress,
      child: Card(
        color: ColorOutlet.secondaryDark,
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CommonText(
                      text: taskItem.title.toString(),
                      fontSize: SizeOutlet.textSizeExtraLarge,
                      fontColor: ColorOutlet.textColorTitle,
                    ),
                  ),
                  if (taskItem.pending) ...[
                    const CommonSpacing(SpacingType.width),
                    const CommonLoading(SizeOutlet.loadingForTaskTile)
                  ]
                ],
              ),
              const CommonSpacing(SpacingType.height),
              Row(
                children: [
                  const Icon(
                    Icons.description_outlined,
                    color: ColorOutlet.iconColor,
                  ),
                  const CommonSpacing(SpacingType.width),
                  Expanded(
                    child: CommonText(
                      fontSize: SizeOutlet.textSizeMedium,
                      text: taskItem.description.toString(),
                    ),
                  ),
                ],
              ),
              const CommonSpacing(SpacingType.height),
              Row(
                children: [
                  const Icon(
                    Icons.more_time_outlined,
                    color: ColorOutlet.iconColor,
                  ),
                  const CommonSpacing(SpacingType.width),
                  CommonText(
                    fontSize: SizeOutlet.textSizeMedium,
                    text: taskItem.dueDateString,
                  ),
                ],
              ),
              const CommonSpacing(SpacingType.height),
              Row(
                children: [
                  AnimatedBuilder(
                    animation: controller,
                    builder: (_, child) {
                      return Row(
                        children: [
                          Icon(
                            Icons.av_timer_outlined,
                            color: TaskDueStateColorConverter.convert(taskItem.dueState),
                          ),
                          const CommonSpacing(SpacingType.width),
                          CommonText(
                            fontColor: TaskDueStateColorConverter.convert(taskItem.dueState),
                            fontSize: SizeOutlet.textSizeMedium,
                            text: taskItem.timeElapsed,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

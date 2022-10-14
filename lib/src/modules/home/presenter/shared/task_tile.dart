import 'package:flutter/material.dart';
import 'package:task/src/core/domain/entities/task_entity.dart';

import '../../../../core/presenter/shared/common_spacing.dart';
import '../../../../core/presenter/shared/common_text.dart';
import '../../../../core/presenter/theme/color_outlet.dart';
import '../../../../core/presenter/theme/size_outlet.dart';
import '../../../../core/presenter/theme/spacing_type.dart';

class TaskTile extends StatelessWidget {
  final TaskEntity taskItem;

  const TaskTile({Key? key, required this.taskItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorOutlet.secondaryDark,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: taskItem.title.toString(),
                  fontSize: SizeOutlet.textSizeLarge,
                  fontColor: ColorOutlet.textColorTitle,
                ),
                const CommonSpacing(SpacingType.height),
                Row(
                  children: [
                    const Icon(
                      Icons.description_outlined,
                      color: ColorOutlet.iconColor,
                    ),
                    const CommonSpacing(SpacingType.width),
                    CommonText(
                      text: taskItem.description.toString(),
                    ),
                  ],
                ),
                const CommonSpacing(SpacingType.height),
                Row(
                  children: [
                    const Icon(
                      Icons.timer_outlined,
                      color: ColorOutlet.iconColor,
                    ),
                    const CommonSpacing(SpacingType.width),
                    CommonText(
                      text: taskItem.dueDate.toString(),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

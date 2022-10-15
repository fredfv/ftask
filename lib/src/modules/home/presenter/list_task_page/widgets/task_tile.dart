import 'package:flutter/material.dart';
import 'package:task/src/modules/home/models/task_tile_model.dart';
import 'package:task/src/modules/home/shared/task_due_state_color_converter.dart';

import '../../../../../core/presenter/shared/common_spacing.dart';
import '../../../../../core/presenter/shared/common_text.dart';
import '../../../../../core/presenter/theme/color_outlet.dart';
import '../../../../../core/presenter/theme/size_outlet.dart';
import '../../../../../core/presenter/theme/spacing_type.dart';

class TaskTile extends StatelessWidget {
  final TaskTileModel taskItem;

  const TaskTile({Key? key, required this.taskItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorOutlet.secondaryDark,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.35,
              child: CommonText(
                text: taskItem.title.toString(),
                fontSize: SizeOutlet.textSizeExtraLarge,
                fontColor: ColorOutlet.textColorTitle,
              ),
            ),
            const CommonSpacing(SpacingType.height),
            Row(
              children: [
                const Icon(
                  Icons.description_outlined,
                  color: ColorOutlet.iconColor,
                ),
                const CommonSpacing(SpacingType.width),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
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
                  Icons.timer_outlined,
                  color: ColorOutlet.iconColor,
                ),
                const CommonSpacing(SpacingType.width),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: CommonText(
                    fontSize: SizeOutlet.textSizeMedium,
                    text: '${taskItem.dueDate.substring(0, 10)}\n${taskItem.dueDate.substring(11, 16)}',
                  ),
                ),
              ],
            ),
            CommonText(text: taskItem.timeElapsed),
            Container(
              width: 10,
              height: 10,
              color: TaskDueStateColorConverter.get(taskItem.dueState),
            )
          ],
        ),
      ),
    );
  }
}

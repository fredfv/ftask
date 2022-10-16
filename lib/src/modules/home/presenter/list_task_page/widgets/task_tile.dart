import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:task/src/modules/home/models/task_tile_model.dart';
import 'package:task/src/modules/home/shared/task_due_state_color_converter.dart';

import '../../../../../core/presenter/shared/common_spacing.dart';
import '../../../../../core/presenter/shared/common_text.dart';
import '../../../../../core/presenter/theme/color_outlet.dart';
import '../../../../../core/presenter/theme/size_outlet.dart';
import '../../../../../core/presenter/theme/spacing_type.dart';

class TaskTile extends StatefulWidget {
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
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  double _onBoardOpacityValue = 1;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _onBoardOpacityValue,
      duration: const Duration(milliseconds: 300),
      onEnd: () {
        widget.onLongPress();
        setState(() {});
      },
      child: InkWell(
        onTap: () async {
          setState(() {
            _onBoardOpacityValue = 0;
          });
        },
        child: Card(
          color: ColorOutlet.secondaryDark,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  text: widget.taskItem.title.toString(),
                  fontSize: SizeOutlet.textSizeExtraLarge,
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
                    Expanded(
                      child: CommonText(
                        fontSize: SizeOutlet.textSizeMedium,
                        text: widget.taskItem.description.toString(),
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
                      text: widget.taskItem.dueDateString,
                    ),
                  ],
                ),
                const CommonSpacing(SpacingType.height),
                AnimatedBuilder(
                  animation: widget.controller!,
                  builder: (_, child) {
                    return Row(
                      children: [
                        Icon(
                          Icons.av_timer_outlined,
                          color: TaskDueStateColorConverter.convert(widget.taskItem.dueState),
                        ),
                        const CommonSpacing(SpacingType.width),
                        CommonText(
                          fontColor: TaskDueStateColorConverter.convert(widget.taskItem.dueState),
                          fontSize: SizeOutlet.textSizeMedium,
                          text: widget.taskItem.timeElapsed,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

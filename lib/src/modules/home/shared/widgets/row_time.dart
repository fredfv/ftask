import 'package:flutter/material.dart';

import '../../../../core/presenter/shared/common_spacing.dart';
import '../../../../core/presenter/shared/common_text.dart';
import '../../../../core/presenter/theme/responsive_outlet.dart';
import '../../models/task_due_state.dart';
import '../task_due_state_color_converter.dart';

class RowTime extends StatelessWidget {
  final String text;
  final TaskDueState dueState;

  const RowTime({
    Key? key,
    required this.text,
    required this.dueState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer_off_outlined,
          color: TaskDueStateColorConverter.convert(dueState),
        ),
        CommonSpacing.width(),
        CommonText(
          fontColor: TaskDueStateColorConverter.convert(dueState),
          fontSize: ResponsiveOutlet.textMedium(context),
          text: text,
        ),
      ],
    );
  }
}

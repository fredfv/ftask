import 'package:flutter/material.dart';

import '../../../../core/presenter/shared/common_spacing.dart';
import '../../../../core/presenter/shared/common_text.dart';
import '../../../../core/presenter/theme/size_outlet.dart';
import '../../../../core/presenter/theme/spacing_type.dart';
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
          Icons.check_circle_outline,
          color: TaskDueStateColorConverter.convert(dueState),
        ),
        const CommonSpacing(SpacingType.width),
        CommonText(
          fontColor: TaskDueStateColorConverter.convert(dueState),
          fontSize: SizeOutlet.textSizeMedium,
          text: text,
        ),
      ],
    );
  }
}

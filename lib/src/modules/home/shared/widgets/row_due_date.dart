import 'package:flutter/material.dart';

import '../../../../core/presenter/shared/common_spacing.dart';
import '../../../../core/presenter/shared/common_text.dart';
import '../../../../core/presenter/theme/color_outlet.dart';
import '../../../../core/presenter/theme/size_outlet.dart';
import '../../../../core/presenter/theme/spacing_type.dart';

class RowDueDate extends StatelessWidget {
  final String text;
  const RowDueDate({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.more_time_outlined,
          color: ColorOutlet.iconColor,
        ),
        const CommonSpacing(SpacingType.width),
        CommonText(
          fontSize: SizeOutlet.textSizeMedium,
          text: text,
        ),
      ],
    );
  }
}

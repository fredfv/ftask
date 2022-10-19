import 'package:flutter/material.dart';
import 'package:task/src/core/presenter/theme/responsive_outlet.dart';

import '../theme/size_outlet.dart';
import '../theme/spacing_type.dart';

class CommonSpacing extends StatelessWidget {
  ///dont pass zero
  final double factor;
  final SpacingType type;

  const CommonSpacing(this.type, {Key? key, this.factor = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == SpacingType.height
        ? SizedBox(height: ResponsiveOutlet.height(context) * SizeOutlet.spacingHeight * factor)
        : SizedBox(width: ResponsiveOutlet.width(context) * SizeOutlet.spacingWidth * factor);
  }
}

import 'package:flutter/material.dart';

import '../theme/spacing_type.dart';

class CommonSpacing extends StatelessWidget {
  ///dont pass zero
  final double factor;
  final SpacingType type;
  const CommonSpacing(this.type, {Key? key, this.factor = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == SpacingType.height
        ? SizedBox(height: MediaQuery.of(context).size.height * 0.01 * factor)
        : SizedBox(width: MediaQuery.of(context).size.width * 0.015 * factor);
  }
}

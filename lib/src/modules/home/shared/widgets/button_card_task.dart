import 'package:flutter/material.dart';

import '../../../../core/presenter/theme/color_outlet.dart';
import '../../../../core/presenter/theme/responsive_outlet.dart';
import '../../../../core/presenter/theme/size_outlet.dart';

class ButtonCardTask extends StatelessWidget {
  final List<Widget> children;
  final VoidCallback onLongPress;

  const ButtonCardTask({
    Key? key,
    required this.children,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      child: Card(
        color: ColorOutlet.secondaryDark,
        elevation: SizeOutlet.elevationDefault,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeOutlet.cornerRadiusDefault),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            ResponsiveOutlet.paddingMedium(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
}

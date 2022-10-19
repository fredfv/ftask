import 'package:flutter/material.dart';

import '../../../../core/presenter/theme/color_outlet.dart';

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
        elevation: 7,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
}

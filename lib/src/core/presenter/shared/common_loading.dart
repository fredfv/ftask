import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../theme/color_outlet.dart';

class CommonLoading extends StatelessWidget {
  final double size;

  const CommonLoading(this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.dotsTriangle(color: ColorOutlet.secondary, size: size);
  }
}

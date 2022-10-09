import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../color_outlet.dart';

class CommonLoading extends StatelessWidget {
  final int size;
  const CommonLoading(this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.dotsTriangle(
      color: ColorOutlet.secondary,
      size: MediaQuery.of(context).size.width /
          MediaQuery.of(context).size.height *
          size,
    );
  }
}

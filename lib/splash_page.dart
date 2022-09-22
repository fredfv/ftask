import 'package:core/domain/repositories/color_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:task/app_module.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then((_) async {
      await Modular.isModuleReady<AppModule>();
      Modular.to.navigate('/src/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorRepository.primary,
      child: Center(
        child: LoadingAnimationWidget.dotsTriangle(
          color: ColorRepository.secondary,
          size: MediaQuery.of(context).size.width /
              MediaQuery.of(context).size.height *
              250,
        ),
      ),
    );
  }
}

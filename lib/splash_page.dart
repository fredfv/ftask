import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/app_module.dart';
import 'package:task/src/core/infra/application/logger.dart';
import 'package:task/src/core/infra/services/broadcast_controller.dart';

import 'src/core/infra/services/signalr_helper.dart';
import 'src/core/presenter/shared/common_loading.dart';
import 'src/core/presenter/theme/color_outlet.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 900)).then((_) async {
      await Modular.isModuleReady<AppModule>();

      try {
        await Modular.get<SignalRHelper>().initConnection().timeout(const Duration(seconds: 5));
      } catch (e) {
        fLog.e(e);
      }

      Modular.to.navigate('/src/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorOutlet.primary,
      child: const Center(child: CommonLoading(150)),
    );
  }
}

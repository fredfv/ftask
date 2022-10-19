import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/app_module.dart';
import 'package:task/src/core/domain/entities/user_entity.dart';
import 'package:task/src/core/domain/repositories/i_repository.dart';
import 'package:task/src/core/infra/application/logger.dart';
import 'package:task/src/core/infra/repositories/hive_repository_factory.dart';

import 'src/core/domain/repositories/i_repository_factory.dart';
import 'src/core/infra/services/signalr_helper.dart';
import 'src/core/presenter/shared/common_loading.dart';
import 'src/core/presenter/theme/color_outlet.dart';

class SplashPage extends StatefulWidget {
  final SignalRHelper signalRHelper;
  final IRepositoryFactory repositoryFactory;
  const SplashPage({
    Key? key,
    required this.signalRHelper,
    required this.repositoryFactory,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    initApp();
  }

  Future<void> initApp() async {
    await Modular.isModuleReady<AppModule>();
    try {
      await Future.delayed(const Duration(milliseconds: 900));
      await widget.signalRHelper.initConnection().timeout(const Duration(seconds: 3));
      IRepository<UserEntity> userRepo = await widget.repositoryFactory.get<UserEntity>();
      await userRepo.getAll().then((value) {
        if (value.isNotEmpty) {
          Modular.get<UserEntity>().setAuthUser(value.last);
          Modular.to.pushReplacementNamed('/home/');
        } else {
          Modular.to.pushReplacementNamed('/src/');
        }
      }).onError((error, stackTrace) {
        fLog.e(error);
        Modular.to.pushReplacementNamed('/src/');
      });
    } catch (e) {
      fLog.e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorOutlet.primary,
      child: const Center(child: CommonLoading(200)),
    );
  }
}

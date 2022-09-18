import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/app_module.dart';
import 'package:task/app_widget.dart';
import 'package:task/core/logger.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Modular.to.addListener(() {
    fLog.wtf(Modular.to.path);
  });

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
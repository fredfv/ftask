import 'package:core/domain/presentation/color_outlet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
          fontFamily: 'Sansation',
          textSelectionTheme: const TextSelectionThemeData(
              selectionColor: ColorOutlet.selectedText,
              selectionHandleColor: ColorOutlet.selectedHandler)),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      debugShowCheckedModeBanner: false,
    );
  }
}

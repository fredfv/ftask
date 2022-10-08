import 'package:flutter/material.dart';
import 'package:task/src/core/ui/color_outlet.dart';

class CommonScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? navBar;
  const CommonScaffold(
      {Key? key, required this.title, required this.child, this.navBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorOutlet.primary,
      appBar: AppBar(
          centerTitle: true,
          title: Text(title),
          backgroundColor: ColorOutlet.primary,
          iconTheme: const IconThemeData(color: ColorOutlet.secondary),
          titleTextStyle: TextStyle(
              fontFamily: 'Sansation',
              color: ColorOutlet.secondary,
              fontSize: MediaQuery.of(context).size.width /
                  MediaQuery.of(context).size.height *
                  35)),
      body: child,
      bottomNavigationBar: navBar,
    );
  }
}

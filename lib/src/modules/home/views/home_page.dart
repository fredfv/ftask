import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task/src/core/domain/dictionary.dart';
import 'package:task/src/core/ui/color_outlet.dart';
import 'package:task/src/core/ui/widgets/common_scaffold.dart';
import 'package:task/src/modules/home/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;

  const HomePage({Key? key, required this.controller}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: Dictionary.homePage,
      navBar: AnimatedBuilder(
        animation: widget.controller,
        builder: (BuildContext context, Widget? child) {
          return BottomNavigationBar(
            backgroundColor: ColorOutlet.navBar,
            showSelectedLabels: true,
            type: BottomNavigationBarType.fixed,
            fixedColor: ColorOutlet.secondary,
            currentIndex: widget.controller.pageSelectedIndex,
            onTap: (index) {
              widget.controller.changePage(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Task'),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks')
            ],
          );
        },
      ),
      child: const RouterOutlet(),
    );
  }
}

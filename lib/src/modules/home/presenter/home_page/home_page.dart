import 'package:flutter/material.dart';

import '../../../../core/presenter/shared/common_scaffold.dart';
import '../../../../core/presenter/shared/common_snackbar.dart';
import '../../../../core/presenter/theme/color_outlet.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;

  const HomePage({Key? key, required this.controller}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    widget.controller.homeStateValueListenable.addListener(() {
      if (widget.controller.homeStateValueListenable.value != '') {
        ScaffoldMessenger.of(context).showSnackBar(CommonSnackBar(
            content: Text(widget.controller.homeStateValueListenable.value), backgroundColor: ColorOutlet.error));
        widget.controller.homeStateValueListenable.value = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        bottonNavBar: AnimatedBuilder(
          animation: widget.controller,
          builder: (BuildContext context, Widget? child) {
            return BottomNavigationBar(
              backgroundColor: ColorOutlet.bottomNavBarBackground,
              unselectedItemColor: ColorOutlet.bottomNavBarItemUnselected,
              selectedItemColor: ColorOutlet.bottomNavBarItemSelected,
              type: BottomNavigationBarType.fixed,
              currentIndex: widget.controller.pageSelectedIndex,
              onTap: (index) {
                widget.controller.changePage(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Task'),
                BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
                BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chats'),
              ],
            );
          },
        ),
        body: PageView(
          controller: widget.controller.pageController,
          children: widget.controller.pages,
        ));
  }
}

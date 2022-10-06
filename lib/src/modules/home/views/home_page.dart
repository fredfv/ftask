import 'package:flutter/material.dart';
import 'package:task/src/modules/home/controllers/home_controller.dart';

import '../../../core/ui/color_outlet.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;

  const HomePage({Key? key, required this.controller}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {}

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorOutlet.primary,
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Create new account'),
          backgroundColor: ColorOutlet.primary,
          iconTheme: const IconThemeData(color: ColorOutlet.secondary),
          titleTextStyle: TextStyle(
              fontFamily: 'Sansation',
              color: ColorOutlet.secondary,
              fontSize: MediaQuery.of(context).size.width /
                  MediaQuery.of(context).size.height *
                  35)),
      body: AnimatedBuilder(
          animation: widget.controller.hub,
          builder: (context, child) {
            return Text(widget.controller.hub.value, style: TextStyle(color: Colors.white),);
          }),
    );
  }
}

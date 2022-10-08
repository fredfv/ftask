import 'package:flutter/material.dart';
import 'package:task/src/core/domain/dictionary.dart';
import 'package:task/src/core/ui/color_outlet.dart';
import 'package:task/src/core/ui/widgets/common_scaffold.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CommonScaffold(
      title: Dictionary.tasksPage,
      child: Center(
        child: Text(
          'Minhas tasks',
          style: TextStyle(color: ColorOutlet.secondary),
        ),
      ),
    );
  }
}

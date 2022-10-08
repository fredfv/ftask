import 'package:flutter/material.dart';
import 'package:task/src/core/domain/dictionary.dart';
import 'package:task/src/core/ui/widgets/common_scaffold.dart';

import '../../../core/ui/color_outlet.dart';

class ListTaskPage extends StatelessWidget {
  final String id;

  const ListTaskPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CommonScaffold(
      title: Dictionary.taskPage,
      child: Text(
        'Task list page',
        style: TextStyle(color: ColorOutlet.secondary),
      ),
    );
  }
}

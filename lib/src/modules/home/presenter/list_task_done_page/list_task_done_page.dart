import 'package:flutter/material.dart';

import '../../../../core/presenter/shared/common_scaffold.dart';
import '../../../../core/presenter/theme/color_outlet.dart';
import '../../../../core/presenter/theme/dictionary.dart';

class ListTaskDonePage extends StatelessWidget {
  const ListTaskDonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CommonScaffold(
      title: Dictionary.chatsPage,
      body: Center(
        child: Text(
          'Meus chats',
          style: TextStyle(color: ColorOutlet.secondary),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/presenter/shared/common_scaffold.dart';
import '../../../../core/presenter/theme/color_outlet.dart';
import '../../../../core/presenter/theme/dictionary.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

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

import 'package:flutter/material.dart';
import 'package:task/src/core/infra/dictionary.dart';
import 'package:task/src/core/ui/color_outlet.dart';
import 'package:task/src/core/ui/widgets/common_scaffold.dart';

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

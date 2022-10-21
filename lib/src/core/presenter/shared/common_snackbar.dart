import 'package:flutter/material.dart';

class CommonSnackBar extends SnackBar {
  const CommonSnackBar({super.key, required super.content, required super.backgroundColor});

  @override
  Duration get duration => const Duration(milliseconds: 1500);

  factory CommonSnackBar.fromSuccess(String content, {Key? key}) => CommonSnackBar(
        key: key,
        content: Text(content),
        backgroundColor: Colors.green,
      );

  factory CommonSnackBar.fromError(String content, {Key? key, required}) => CommonSnackBar(
        key: key,
        content: Text(content),
        backgroundColor: Colors.red,
      );
}

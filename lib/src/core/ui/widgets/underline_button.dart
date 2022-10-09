import 'package:flutter/material.dart';

import '../color_outlet.dart';

class UnderLineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String description;

  const UnderLineButton(
      {Key? key, required this.onPressed, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith(
            (states) => ColorOutlet.selectedText),
      ),
      onPressed: onPressed,
      child: Text(
        description,
        style: const TextStyle(
            color: ColorOutlet.secondaryDark,
            decoration: TextDecoration.underline),
      ),
    );
  }
}

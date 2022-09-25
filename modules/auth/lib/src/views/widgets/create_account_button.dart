import 'package:core/infra/color_outlet.dart';
import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CreateAccountButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.07),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateColor.resolveWith(
              (states) => ColorOutlet.selectedText),
        ),
        onPressed: onPressed,
        child: const Text(
          'create account',
          style: TextStyle(
              color: ColorOutlet.secondaryDark,
              decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LoginEntry extends StatelessWidget {
  const LoginEntry({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.icon,
    required this.hintText,
    required this.labeltext,
  }) : super(key: key);
  final TextEditingController controller;
  final bool obscureText;
  final Icon icon;
  final String hintText;
  final String labeltext;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery
            .of(context)
            .size
            .width * 0.13, vertical:
        MediaQuery
            .of(context)
            .size
            .height * 0.022),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          obscuringCharacter: '-',
          decoration: InputDecoration(
            icon: icon,
            hintText: hintText,
            labelText: labeltext,
          ),
        ),
      ),
    );
  }
}

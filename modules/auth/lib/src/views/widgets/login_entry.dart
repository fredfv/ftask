import 'package:core/domain/repositories/color_repository.dart';
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
  final IconData icon;
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
          style: const TextStyle(
            color: ColorRepository.secondary,
          ),
          cursorColor: ColorRepository.secondary,
          controller: controller,
          obscureText: obscureText,
          obscuringCharacter: 'ж',
          decoration: InputDecoration(
            labelStyle: const TextStyle(
              color: ColorRepository.secondaryDark
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorRepository.secondary,
              )
            ),
            //icon: Icon(icon, color: ColorRepository.secondaryDark),
            //hintText: hintText,
            labelText: labeltext,
            hintStyle: const TextStyle(
                color: ColorRepository.shadow
            ),
          ),
        ),
      ),
    );
  }
}

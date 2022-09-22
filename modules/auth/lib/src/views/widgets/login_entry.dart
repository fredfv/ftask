import 'package:core/domain/repositories/color_repository.dart';
import 'package:flutter/material.dart';

class LoginEntry extends StatelessWidget {
  const LoginEntry(
      {Key? key,
      required this.controller,
      required this.obscureText,
      required this.icon,
      required this.hintText,
      required this.labeltext,
      required this.onFieldSubmitted,
      this.focusNode})
      : super(key: key);
  final TextEditingController controller;
  final bool obscureText;
  final IconData icon;
  final String hintText;
  final String labeltext;
  final Function(String) onFieldSubmitted;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.13,
          vertical: MediaQuery.of(context).size.height * 0.022),
      child: TextFormField(
        scrollPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.3),
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        style: const TextStyle(
          color: ColorRepository.secondary,
        ),
        cursorColor: ColorRepository.secondary,
        controller: controller,
        obscureText: obscureText,
        obscuringCharacter: 'ж',
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: ColorRepository.secondaryDark),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: ColorRepository.secondary,
          )),
          //icon: Icon(icon, color: ColorRepository.secondaryDark),
          //hintText: hintText,
          labelText: labeltext,
          hintStyle: const TextStyle(color: ColorRepository.shadow),
        ),
      ),
    );
  }
}

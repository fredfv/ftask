import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../color_outlet.dart';

class CommonTextFormField extends StatelessWidget {
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  final String label;
  final String value;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CommonTextFormField({
    Key? key,
    required this.label,
    required this.value,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.35),
        onFieldSubmitted: onFieldSubmitted,
        focusNode: focusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: inputFormatters,
        initialValue: value.toString(),
        validator: validator,
        onChanged: onChanged,
        style: const TextStyle(color: ColorOutlet.secondary),
        cursorColor: ColorOutlet.secondary,
        obscureText: obscureText,
        obscuringCharacter: 'ж',
        decoration: _inputDecoration());
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      labelText: label,
      focusedErrorBorder: _outlineInputBorderError(),
      errorStyle: const TextStyle(color: ColorOutlet.error),
      errorBorder: _outlineInputBorderError(),
      labelStyle: const TextStyle(color: ColorOutlet.secondaryDark),
      focusedBorder: _outlineInputBorderSecondary(),
      hintStyle: const TextStyle(color: ColorOutlet.shadow),
      border: _outlineInputBorderSecondary(),
    );
  }

  OutlineInputBorder _outlineInputBorderSecondary() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: ColorOutlet.secondary),
    );
  }

  OutlineInputBorder _outlineInputBorderError() {
    return const OutlineInputBorder(
      borderSide: BorderSide(color: ColorOutlet.error),
    );
  }
}

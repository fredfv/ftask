import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/color_outlet.dart';

class CommonTextFormField extends StatelessWidget {
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  final String label;
  final String? initialValue;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CommonTextFormField(
      {Key? key,
      required this.label,
      this.initialValue,
      this.onChanged,
      this.validator,
      this.obscureText = false,
      this.inputFormatters,
      this.onFieldSubmitted,
      this.focusNode,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.35),
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters,
      initialValue: initialValue?.toString(),
      validator: validator,
      onChanged: onChanged,
      style: const TextStyle(color: ColorOutlet.secondary),
      cursorColor: ColorOutlet.secondary,
      obscureText: obscureText,
      obscuringCharacter: 'ж',
      decoration: _inputDecoration(),
      controller: controller,
    );
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

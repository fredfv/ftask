import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/src/core/presenter/theme/responsive_outlet.dart';

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
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters,
      initialValue: initialValue?.toString(),
      validator: validator,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: ResponsiveOutlet.textMedium(context),
        color: ColorOutlet.secondary,
      ),
      cursorColor: ColorOutlet.secondary,
      obscureText: obscureText,
      obscuringCharacter: 'ж',
      decoration: _inputDecoration(context),
      controller: controller,
    );
  }

  InputDecoration _inputDecoration(BuildContext context) {
    return InputDecoration(
      labelText: label,
      focusedErrorBorder: _outlineInputBorderError(),
      errorStyle: TextStyle(color: ColorOutlet.error, fontSize: ResponsiveOutlet.textDefault(context)),
      errorBorder: _outlineInputBorderError(),
      labelStyle: TextStyle(color: ColorOutlet.secondaryDark, fontSize: ResponsiveOutlet.textMedium(context)),
      focusedBorder: _outlineInputBorderSecondary(),
      hintStyle: TextStyle(color: ColorOutlet.shadow, fontSize: ResponsiveOutlet.textMedium(context)),
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

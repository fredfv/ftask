import 'package:core/domain/repositories/color_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateAccountEntry extends StatelessWidget {
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  final String label;
  final String value;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CreateAccountEntry({
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
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.02,
        horizontal: MediaQuery.of(context).size.width * 0.01,
      ),
      child: TextFormField(
        scrollPadding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.35),
        onFieldSubmitted: onFieldSubmitted,
        focusNode: focusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: inputFormatters,
        initialValue: value.toString(),
        validator: validator,
        onChanged: onChanged,
        style: const TextStyle(
          color: ColorRepository.secondary,
        ),
        cursorColor: ColorRepository.secondary,
        obscureText: obscureText,
        obscuringCharacter: 'ж',
        decoration: InputDecoration(
          errorStyle: const TextStyle(
            color: ColorRepository.error
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorRepository.secondary,
            ),
          ),
          labelStyle: const TextStyle(color: ColorRepository.secondaryDark),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorRepository.secondary,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
            color: ColorRepository.secondary,
          )),
          labelText: label,
          hintStyle: const TextStyle(color: ColorRepository.shadow),
        ),
      ),
    );
  }
}

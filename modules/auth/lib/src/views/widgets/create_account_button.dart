import 'package:core/domain/repositories/color_repository.dart';
import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                      (states) => ColorRepository.shadow),
              backgroundColor: MaterialStateColor.resolveWith(
                      (states) => ColorRepository.primary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                      side: const BorderSide(color: ColorRepository.shadow)))),
          child: Text(
            'Create',
            style: TextStyle(
                color: ColorRepository.secondary,
                fontSize: MediaQuery.of(context).size.width /
                    MediaQuery.of(context).size.height *
                    30),
          )),
    );
  }
}

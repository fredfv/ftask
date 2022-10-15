import 'package:flutter/material.dart';

import '../theme/color_outlet.dart';

class CommonButton extends StatelessWidget {
  final String description;

  const CommonButton(
      {Key? key, required this.onPressed, required this.description})
      : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => ColorOutlet.shadow),
            backgroundColor:
                MaterialStateColor.resolveWith((states) => ColorOutlet.primary),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                    side: const BorderSide(color: ColorOutlet.shadow)))),
        child: Text(description,
            style: TextStyle(
                color: ColorOutlet.secondary,
                fontSize: MediaQuery.of(context).size.width /
                    MediaQuery.of(context).size.height *
                    30)));
  }
}

import 'package:core/infra/color_outlet.dart';
import 'package:flutter/material.dart';

class SubimitAccountButton extends StatelessWidget {
  const SubimitAccountButton({Key? key, required this.onPressed})
      : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => ColorOutlet.shadow),
            backgroundColor:
                MaterialStateColor.resolveWith((states) => ColorOutlet.primary),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
                side: const BorderSide(
                  color: ColorOutlet.shadow,
                ),
              ),
            ),
          ),
          child: Text(
            'Create',
            style: TextStyle(
                color: ColorOutlet.secondary,
                fontSize: MediaQuery.of(context).size.width /
                    MediaQuery.of(context).size.height *
                    30),
          )),
    );
  }
}

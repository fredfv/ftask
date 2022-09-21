import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            'Login',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width /
                    MediaQuery.of(context).size.height *
                    30),
          )),
    );
  }
}

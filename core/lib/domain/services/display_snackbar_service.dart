import 'package:flutter/material.dart';

abstract class DisplaySnackbarService {
  void show(BuildContext context, String msg, Color color);
}

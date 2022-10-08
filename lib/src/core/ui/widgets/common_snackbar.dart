import 'package:flutter/material.dart';

class CommonSnackBar extends SnackBar {
  const CommonSnackBar({super.key, required super.content, required super.backgroundColor});
  @override
  Duration get duration => const Duration(milliseconds: 1500);
}

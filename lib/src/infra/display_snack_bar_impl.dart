import 'package:core/domain/services/display_snackbar_service.dart';
import 'package:flutter/material.dart';

class DisplaySnackbarImp implements DisplaySnackbarService {
  @override
  void show(BuildContext context, String msg, Color color) {
    var snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: color,
      duration: const Duration(milliseconds: 1500),
    );
    Future.delayed(const Duration(milliseconds: 90), () {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}

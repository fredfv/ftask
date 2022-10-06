import 'package:flutter/material.dart';

abstract class FormsValidateService {
  bool validate();

  final form = GlobalKey<FormState>();
}

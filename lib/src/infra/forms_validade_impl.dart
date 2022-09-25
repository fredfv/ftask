import 'package:core/domain/services/form_validade_service.dart';
import 'package:flutter/material.dart';

class FormsValidateImpl implements FormsValidateService {
  final _formValidate = GlobalKey<FormState>();

  @override
  GlobalKey<FormState> get form => _formValidate;

  @override
  bool validate() {
    return form.currentState?.validate() ?? false;
  }
}

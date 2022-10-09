import 'package:flutter/material.dart';

import '../../services/form_validate_service.dart';

class FormsValidateImpl implements FormsValidateService {
  final _formValidate = GlobalKey<FormState>();

  @override
  GlobalKey<FormState> get form => _formValidate;

  @override
  bool validate() {
    return form.currentState?.validate() ?? false;
  }
}

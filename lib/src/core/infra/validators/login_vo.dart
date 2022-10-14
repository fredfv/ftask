import 'value_object.dart';

class LoginVO implements ValueObject {
  final String? _value;

  LoginVO(this._value);

  @override
  String? validator() {
    if (_value?.isEmpty ?? true) {
      return 'fill the field to submit';
    }

    return null;
  }
}

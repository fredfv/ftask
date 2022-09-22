import 'package:core/domain/value_objects/value_object.dart';

class NameVO implements ValueObject {
  final String _value;

  NameVO(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'fill the field to submit';
    }

    if (_value.split(' ').length < 2) {
      return 'fill it with full name';
    }

    return null;
  }

  @override
  String toString() => _value;
}

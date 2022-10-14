import 'value_object.dart';

class DueDateVO implements ValueObject {
  final String _value;

  DueDateVO(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'fill the field to create a task';
    }

    if (RegExp(r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$').hasMatch(_value) == false) {
      return 'fill it with a valid hour';
    }

    return null;
  }

  @override
  String toString() => _value;
}

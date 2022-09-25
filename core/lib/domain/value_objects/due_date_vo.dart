import 'package:core/domain/value_objects/value_object.dart';

class DueDateVO implements ValueObject {
  final String _value;

  DueDateVO(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'fill the field to create a task';
    }

    //todo validar se é uma hora

    return null;
  }

  @override
  String toString() => _value;
}

import 'value_object.dart';

class DescriptionVO implements ValueObject {
  final String _value;

  DescriptionVO(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'fill the field to create a task';
    }

    return null;
  }

  @override
  String toString() => _value;
}

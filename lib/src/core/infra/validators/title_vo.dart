import 'value_object.dart';

class TitleVO implements ValueObject {
  final String? _value;

  TitleVO(this._value);

  @override
  String? validator() {
    if (_value?.isEmpty ?? true) {
      return 'fill the field to add new task';
    }
    return null;
  }
}

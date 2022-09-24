import 'package:core/domain/value_objects/value_object.dart';

class SecretVO implements ValueObject {
  final String _value;

  SecretVO(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'fill the field to submit';
    }
    return null;
  }

  String? secretMatches(String? passwordToMatch){
    if(_value != passwordToMatch){
      return 'passwords do not match';
    }
    return null;
  }

  @override
  String toString() => _value;
}

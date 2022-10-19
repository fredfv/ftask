import '../../presenter/theme/lexicon.dart';
import 'validation_base.dart';

class NameValidator implements ValidationBase {
  final String _value;

  NameValidator(this._value);

  @override
  String? validate() {
    if (_value.isEmpty) return Lexicon.fillTheFieldToSubmit;
    if (_value.split(' ').length < 2) return Lexicon.fillWithFullName;
    return null;
  }
}

import '../../presenter/theme/lexicon.dart';
import 'validation_base.dart';

class NameValidator implements ValidationBase {
  final String? _value;
  final RegExp rex = RegExp(r"^([a-zA-Z]{2,}\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)");
  //regext to validade a name
  //https://stackoverflow.com/questions/16699007/regular-expression-to-match-standard-uk-postcodes

  NameValidator(this._value);

  @override
  String? validate() {
    if (_value?.isEmpty ?? true) return Lexicon.fillTheFieldToSubmit;
    if (rex.hasMatch(_value ?? '')) return Lexicon.fillWithFullName;
    return null;
  }
}

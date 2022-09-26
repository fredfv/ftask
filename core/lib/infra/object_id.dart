import 'package:core/domain/services/object_id_service.dart';
import 'package:objectid/objectid.dart' as oi;

class ObjectId implements ObjectIdService {
  @override
  String generate() => oi.ObjectId().hexString;
}

import 'package:objectid/objectid.dart' as oi;

import '../services/object_id_service.dart';

class ObjectId implements ObjectIdService {
  @override
  String generate() => oi.ObjectId().hexString;
}

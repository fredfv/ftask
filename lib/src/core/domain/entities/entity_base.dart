abstract class EntityBase {
  String _id;
  DateTime _created;
  DateTime _persisted;
  DateTime? _deleted;
  DateTime? _updated;

  String get id => _id;

  DateTime get created => _created;

  DateTime get persisted => _persisted;

  DateTime? get deleted => _deleted;

  DateTime? get updated => _updated;

  void setId(String value) => _id = value;

  void setCreated(DateTime value) => _created = value;

  void setPersisted(DateTime value) => _persisted = value;

  void setDeleted(DateTime? value) => _deleted = value;

  void setUpdated(DateTime? value) => _updated = value;

  EntityBase({
    required String id,
    required DateTime created,
    required DateTime persisted,
    DateTime? deleted,
    DateTime? updated,
  })  : _id = id,
        _created = created,
        _persisted = persisted,
        _deleted = deleted,
        _updated = updated;

  Map<String, dynamic> toJson();
}

abstract class EntityBase {
  String _id;
  DateTime _created;
  DateTime _persisted;

  String get id => _id;

  DateTime get created => _created;

  DateTime get persisted => _persisted;

  void setId(String? value) => _id = value ?? '';

  void setCreated(DateTime? value) => _created = value ?? DateTime.now();

  void setPersisted(DateTime? value) => _persisted = value ?? DateTime.now();

  EntityBase({required String id, required DateTime created, required DateTime persisted})
      : _id = id,
        _created = created,
        _persisted = persisted;

  Map<String, dynamic> toJson();
}

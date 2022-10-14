abstract class EntityBase {
  String _id;
  DateTime _created;

  String get id => _id;
  DateTime get created => _created;
  void setId(String? value) => _id = value ?? '';
  void setCreated(DateTime? value) => _created = value ?? DateTime.now();

  EntityBase({required String id, required DateTime created})
      : _id = id,
        _created = created;

  Map<String, dynamic> toJson();
}
